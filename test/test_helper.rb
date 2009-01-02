require 'test/unit'

class Test::Unit::TestCase
  
  def setup
    @backtrace = [ "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/assertions.rb:48:in `assert_block'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/assertions.rb:313:in `flunk'",
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/benchmark.rb:293", 
                   "/Users/james/Documents/railsApps/generating_station/app/controllers/photos_controller.rb:315:in `something'",
                   "/Users/james/Documents/railsApps/generating_station/vendor/plugins/quiet_stacktraces/test/quiet_stacktraces_test.rb:21:in `test_this_plugin'", 
                   "/Library/Ruby/Gems/1.8/gems/activerecord-1.99.0/lib/active_record/connection_adapters/mysql_adapter.rb:471:in `real_connect'",
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/ui/console/testrunner.rb:41:in `start'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit.rb:278", 
                   "/Users/james/Documents/railsApps/generating_station/vendor/plugins/quiet_stacktraces/test/quiet_stacktraces_test.rb:20",
                   "/app/controllers/blogs_controller.rb:5:in `index'",
                   "/Users/dancroak/dev/nationalgazette/vendor/gems/thoughtbot-shoulda-2.0.6/lib/shoulda/context.rb:254:in `test: on a GET to #index.rss should respond with content type of application/rs+xml. '",
                   "/Users/dancroak/dev/nationalgazette/vendor/rails/activesupport/lib/active_support/testing/setup_and_teardown.rb:94:in `__send__'",
                   "/Users/dancroak/dev/nationalgazette/vendor/rails/activesupport/lib/active_support/testing/setup_and_teardown.rb:94:in `run'",
                   "lib/mongrel", "bin/mongrel",
                   "lib/passenger", "bin/passenger-spawn-server",
                   "lib/rack", "script/server", 
                   "rubygems/custom_require", "benchmark.rb"]
  end
  
  # test "verify something" do
  #   ...
  # end
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(test_name) do
        flunk "No implementation provided for #{name}"
      end
    end
  end
  
end