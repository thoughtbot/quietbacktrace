require 'test/unit'
require 'rubygems'
require 'activesupport'

module QuietBacktrace # :nodoc: all
  module BacktraceFilter
    def self.included(klass)
      klass.class_eval { alias_method_chain :filter_backtrace, :quieting }
    end

    mattr_accessor :silencers, :filters
    self.silencers, self.filters = {}, {}

    def filter_backtrace_with_quieting(backtrace)
      filter_backtrace_without_quieting(backtrace)

      # Rails view backtraces are flattened into one String. Adjust.
      backtrace = backtrace.first.split("\n") if backtrace.size == 1

      if Test::Unit::TestCase.quiet_backtrace
        backtrace.reject! do |line|
          [*Test::Unit::TestCase.backtrace_silencers].any? do |silencer_name|
            QuietBacktrace::BacktraceFilter.silencers[silencer_name].call(line) if silencer_name
          end
        end

        backtrace.each do |line|
          [*Test::Unit::TestCase.backtrace_filters].each do |filter_name|
            QuietBacktrace::BacktraceFilter.filters[filter_name].call(line) if filter_name
          end
        end          
      end
      
      backtrace
    end
  end
  
  module TestCase
    def self.included(klass)
      klass.class_eval do
        cattr_accessor :quiet_backtrace, :backtrace_silencers, :backtrace_filters
        self.backtrace_filters, self.backtrace_silencers = [], []
        
        extend ClassMethods
        
        new_backtrace_silencer(:test_unit) do |line|
          (line.include?("ruby") && line.include?("/test/unit"))
        end
        new_backtrace_silencer(:os_x_ruby) do |line| 
          line.include?('Ruby.framework')
        end
        new_backtrace_silencer(:gem_root) do |line| 
          line =~ /ruby\/gems/i
        end
        new_backtrace_silencer(:e1) do |line| 
          line == "-e:1"
        end
        new_backtrace_silencer(:rails_vendor) do |line| 
          (line.include?("vendor/plugins") || 
            line.include?("vendor/gems") || 
            line.include?("vendor/rails"))
        end
        
        new_backtrace_filter(:method_name) do |line| 
          line.slice!((line =~ /:in /)..line.length) if (line =~ /:in /)
        end
        new_backtrace_filter(:rails_root) do |line| 
          line.sub!("#{RAILS_ROOT}/", '') if (defined?(RAILS_ROOT) && line.include?(RAILS_ROOT))
        end
        
        self.quiet_backtrace = true
        self.backtrace_silencers = [:test_unit, :os_x_ruby, :gem_root, :e1]
        self.backtrace_filters = [:method_name]
      end
    end
      
    module ClassMethods
      def new_backtrace_silencer(symbol, &block)
        QuietBacktrace::BacktraceFilter.silencers[symbol] = block
      end
    
      def new_backtrace_filter(symbol, &block)
        QuietBacktrace::BacktraceFilter.filters[symbol] = block
      end
    end
  end
end

Test::Unit::Util::BacktraceFilter.module_eval { include QuietBacktrace::BacktraceFilter }
Test::Unit::TestCase.class_eval { include QuietBacktrace::TestCase }
