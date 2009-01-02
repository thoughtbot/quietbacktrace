require File.dirname(__FILE__) + '/cleaner'

module QuietBacktrace
  module Rails
    class Cleaner < QuietBacktrace::Cleaner
      
      ERB_METHOD_SIG = /:in `_run_erb_.*/

      VENDOR_DIRS = %w( vendor/gems vendor/rails )
      SERVER_DIRS = %w( lib/mongrel bin/mongrel
                        lib/passenger bin/passenger-spawn-server
                        lib/rack )
      RAILS_NOISE = %w( script/server )
      RUBY_NOISE  = %w( rubygems/custom_require benchmark.rb )
      
      ALL_NOISE = VENDOR_DIRS + SERVER_DIRS + RAILS_NOISE + RUBY_NOISE
      
      def initialize
        super
        add_filter { |line| line.sub("#{RAILS_ROOT}/", '') }
        add_filter { |line| line.sub(ERB_METHOD_SIG, '') }
        add_filter { |line| line.sub('./', '/') }
        add_filter do |line| 
          line.sub(/(#{Gem.default_dir})\/gems\/([a-z]+)-([0-9.]+)\/(.*)/, '\2 (\3) \4') 
        end

        add_silencer { |line| ALL_NOISE.any? { |dir| line.include?(dir) } }
        add_silencer { |line| line =~ %r(vendor/plugins/[^\/]+/lib) }
      end
    end

    # For installing the Cleaner in test/unit
    module CleanerForTestUnit
      def self.included(klass)
        klass.send :alias_method, :filter_backtrace_without_cleaning, :filter_backtrace
        klass.send :alias_method, :filter_backtrace, :filter_backtrace_with_cleaning
      end
  
      def filter_backtrace_with_cleaning(backtrace)
        backtrace = filter_backtrace_without_cleaning(backtrace)
        backtrace = backtrace.first.split("\n") if backtrace.size == 1
        cleaner = QuietBacktrace::Rails::Cleaner.new 
        cleaner.clean(backtrace)
      end
    end

  end
end
