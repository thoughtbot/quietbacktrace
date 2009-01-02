require 'test/unit'

class Test::Unit::TestCase
  
  def setup
    @backtrace = [ "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/assertions.rb:48:in `assert_block'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/assertions.rb:495:in `_wrap_assertion'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/assertions.rb:46:in `assert_block'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/assertions.rb:313:in `flunk'",
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/benchmark.rb:293", 
                   "/Users/james/Documents/railsApps/generating_station/app/controllers/photos_controller.rb:315:in `something'",
                   "/Users/james/Documents/railsApps/generating_station/vendor/plugins/quiet_stacktraces/test/quiet_stacktraces_test.rb:21:in `test_this_plugin'", 
                   "/Users/james/Documents/railsApps/generating_station/vendor/plugins/quiet_stacktraces/quiet_stacktraces_test.rb:25:in `test_this_plugin'",
                   "/Library/Ruby/Gems/1.8/gems/activerecord-1.99.0/lib/active_record/connection_adapters/mysql_adapter.rb:471:in `real_connect'",
                   "/Library/Ruby/Gems/1.8/gems/activerecord-1.99.0/lib/active_record/fixtures.rb:895:in `teardown'",
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/ui/testrunnermediator.rb:46:in `run_suite'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/ui/console/testrunner.rb:67:in `start_mediator'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/ui/console/testrunner.rb:41:in `start'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/ui/testrunnerutilities.rb:29:in `run'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/autorunner.rb:216:in `run'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/autorunner.rb:12:in `run'", 
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit.rb:278", 
                   "/Users/james/Documents/railsApps/generating_station/vendor/plugins/quiet_stacktraces/test/quiet_stacktraces_test.rb:20",
                   "/app/controllers/blogs_controller.rb:5:in `index'",
                   "thin (0.6.4) lib/thin/connection.rb:35:in `process'",
                   "thin (0.6.4) lib/thin/connection.rb:23:in `receive_data'",
                   "eventmachine (0.10.0) lib/eventmachine.rb:1056:in `event_callback'",
                   "eventmachine (0.10.0) lib/eventmachine.rb:224:in `run_machine'",
                   "eventmachine (0.10.0) lib/eventmachine.rb:224:in `run'",
                   "thin (0.6.4) lib/thin/server.rb:113:in `start'",
                   "thin (0.6.4) lib/thin/controllers/controller.rb:59:in `start'",
                   "thin (0.6.4) lib/thin/runner.rb:143:in `send'",
                   "thin (0.6.4) lib/thin/runner.rb:143:in `run_command'",
                   "thin (0.6.4) lib/thin/runner.rb:114:in `run!'",
                   "thin (0.6.4) bin/thin:6",
                   "/opt/local/bin/thin:16:in `load'",
                   "/opt/local/bin/thin:16",
                   "/Users/dancroak/dev/nationalgazette/vendor/gems/thoughtbot-shoulda-2.0.6/lib/shoulda/controller/macros.rb:193:in `__bind_1230852072_504846'",
                   "/Users/dancroak/dev/nationalgazette/vendor/gems/thoughtbot-shoulda-2.0.6/lib/shoulda/context.rb:254:in `call'",
                   "/Users/dancroak/dev/nationalgazette/vendor/gems/thoughtbot-shoulda-2.0.6/lib/shoulda/context.rb:254:in `test: on a GET to #index.rss should respond with content type of application/rs+xml. '",
                   "/Users/dancroak/dev/nationalgazette/vendor/rails/activesupport/lib/active_support/testing/setup_and_teardown.rb:94:in `__send__'",
                   "/Users/dancroak/dev/nationalgazette/vendor/rails/activesupport/lib/active_support/testing/setup_and_teardown.rb:94:in `run'",
                   "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/test/unit/testsuite.rb:34:in `run'"]
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