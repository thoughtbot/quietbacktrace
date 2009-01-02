require 'test/unit'

def mix_cleaner_into_test_unit
  require File.join(File.dirname(__FILE__), 'quietbacktrace', 'cleaner')
  
  Test::Unit::Util::BacktraceFilter.module_eval do 
    include QuietBacktrace::CleanerForTestUnit 
  end
end

def mix_rails_cleaner_into_test_unit
  require File.join(File.dirname(__FILE__), 'quietbacktrace', 'rails', 'cleaner')
 
  Test::Unit::Util::BacktraceFilter.module_eval do 
    include QuietBacktrace::Rails::CleanerForTestUnit 
  end
end

if defined?(Rails)
  mix_rails_cleaner_into_test_unit
else
  mix_cleaner_into_test_unit
end
