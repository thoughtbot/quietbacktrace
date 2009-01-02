require 'test/unit'

if defined?(Rails)
  require 'quietbacktrace/rails/cleaner'
 
  Test::Unit::Util::BacktraceFilter.module_eval do 
    include QuietBacktrace::Rails::CleanerForTestUnit 
  end
else
  require 'quietbacktrace/cleaner'
  
  Test::Unit::Util::BacktraceFilter.module_eval do 
    include QuietBacktrace::CleanerForTestUnit 
  end
end
