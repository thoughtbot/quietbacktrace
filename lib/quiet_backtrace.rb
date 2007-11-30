require 'test/unit'
require 'attribute_accessors'
require 'aliasing'

module QuietBacktrace
  module BacktraceFilter
    def self.included(klass)
      klass.class_eval { alias_method_chain :filter_backtrace, :quieting }
    end

    mattr_accessor :silencers
    self.silencers = { :test_unit    => lambda { |line| (line.include?("ruby") && line.include?("/test/unit")) },
                       :gem_root     => lambda { |line| line =~ /ruby\/gems/i },
                       :e1           => lambda { |line| line == "-e:1" },
                       :rails_vendor => lambda { |line| (line.include?("vendor/plugins") || line.include?("vendor/gems") || line.include?("vendor/rails")) }
    }

    mattr_accessor :filters
    self.filters    = { :method_name => lambda { |line| line.slice!((line =~ /:in /)..line.length) if (line =~ /:in /) },
                        :rails_root  => lambda { |line| line.sub!("#{RAILS_ROOT}/", '') if (defined?(RAILS_ROOT) && line.include?(RAILS_ROOT)) }}

    def filter_backtrace_with_quieting(backtrace)
      filter_backtrace_without_quieting(backtrace)

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
        cattr_accessor :quiet_backtrace
        self.quiet_backtrace = true

        cattr_accessor :backtrace_silencers
        self.backtrace_silencers = [:test_unit, :gem_root, :e1]

        cattr_accessor :backtrace_filters
        self.backtrace_filters = [:method_name]
      end
    end
  end
end

Test::Unit::Util::BacktraceFilter.module_eval { include QuietBacktrace::BacktraceFilter }
Test::Unit::TestCase.class_eval { include QuietBacktrace::TestCase }