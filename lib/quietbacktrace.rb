require 'test/unit'
require 'cattr_accessor'
require File.join(File.dirname(__FILE__), 'backtrace_cleaner')

module QuietBacktrace
  module TestCase
    def self.included(klass)
      klass.class_eval do
        cattr_accessor :quiet_backtrace
        self.quiet_backtrace = true
      end
    end
  end
  
  module CleanerForTestUnit
    def self.included(klass)
      klass.send :alias_method, :filter_backtrace_without_cleaning, :filter_backtrace
      klass.send :alias_method, :filter_backtrace, :filter_backtrace_with_cleaning
    end

    def filter_backtrace_with_cleaning(backtrace)
      backtrace = filter_backtrace_without_cleaning(backtrace)
      backtrace = backtrace.first.split("\n") if backtrace.size == 1
      cleaner = QuietBacktrace::BacktraceCleaner.new 
      cleaner.clean(backtrace)
    end
  end
end

Test::Unit::TestCase.class_eval { include QuietBacktrace::TestCase }

if Test::Unit::TestCase.quiet_backtrace
  Test::Unit::Util::BacktraceFilter.module_eval do 
    include QuietBacktrace::CleanerForTestUnit 
  end
end

# module Rails
#   def backtrace_cleaner
#     @@backtrace_cleaner ||= begin
#       QuietBacktrace::BacktraceCleaner.new
#     end
#   end
# end
