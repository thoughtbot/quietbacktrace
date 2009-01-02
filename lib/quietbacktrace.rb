require 'test/unit'

if defined?(Rails)
  require File.join(File.dirname(__FILE__), 'quietbacktrace', 'rails', 'cleaner')
 
  Test::Unit::Util::BacktraceFilter.module_eval do 
    include QuietBacktrace::Rails::CleanerForTestUnit 
  end
else
  require File.join(File.dirname(__FILE__), 'quietbacktrace', 'cleaner')
  
  Test::Unit::Util::BacktraceFilter.module_eval do 
    include QuietBacktrace::CleanerForTestUnit 
  end
end
