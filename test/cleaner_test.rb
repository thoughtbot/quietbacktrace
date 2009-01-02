require File.join(File.dirname(__FILE__), 'test_helper')
require File.join(File.dirname(__FILE__), '..', 'lib', 'quietbacktrace')

class CleanerTest < Test::Unit::TestCase
  
  ["test/unit", "Ruby.framework", "ruby", "-e:1"].each do |each|
    test "silence #{each} noise" do
      self.filter_backtrace(@backtrace.dup).each do |line| 
        assert !line.include?(each),
          "#{each} noise is not being silenced: #{line}"
      end
    end
  end
  
  test "not quiet a legitimate line" do
    rails_app_line = "/Users/james/Documents/railsApps/generating_station/app/controllers/photos_controller.rb:315"
    default_quiet_backtrace = self.filter_backtrace(@backtrace.dup)
    
    assert default_quiet_backtrace.join.include?(rails_app_line), 
      "Rails app line is being quieted: #{default_quiet_backtrace}"
  end

  #   test "Setting quiet backtrace to false" do
  #     self.quiet_backtrace = false
  #     unfiltered_backtrace = self.filter_backtrace(@backtrace.dup)
  #     assert_equal @backtrace, unfiltered_backtrace, 
  #       "Backtrace was silenced when it was told not to. This tool is a dictator."
  #   end
  
end
