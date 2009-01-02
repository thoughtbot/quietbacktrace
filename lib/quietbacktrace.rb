require 'test/unit'
require File.join(File.dirname(__FILE__), 'backtrace_cleaner')

module QuietBacktrace
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

Test::Unit::Util::BacktraceFilter.module_eval do 
  include QuietBacktrace::CleanerForTestUnit 
end
