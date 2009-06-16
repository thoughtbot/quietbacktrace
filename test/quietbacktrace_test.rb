require File.join(File.dirname(__FILE__), 'test_helper')
require File.join(File.dirname(__FILE__), '..', 'lib', 'quietbacktrace')

class RailsCleanerTest < Test::Unit::TestCase

  ["test/unit", "Ruby.framework", "ruby", "-e:1", "shoulda",
   "vendor/gems", "vendor/rails", "vendor/plugins",
   "lib/mongrel", "bin/mongrel",
   "lib/passenger", "bin/passenger-spawn-server",
   "lib/rack", "script/server", "lib/active_record",
   "rubygems/custom_require", "benchmark.rb",
   ":in `_run_erb_."].each do |each|
    test "silence #{each} noise" do
      cleaner.filter_backtrace(@backtrace.dup).each do |line|
        assert !line.include?(each),
          "#{each} noise is not being silenced: #{line}"
      end
    end
  end

  test "do not clean a legitimate line" do
    rails_app_line = "/Users/james/Documents/railsApps/generating_station/app/controllers/photos_controller.rb:315"
    default_quiet_backtrace = cleaner.filter_backtrace(@backtrace.dup)

    assert default_quiet_backtrace.join.include?(rails_app_line),
      "Rails app line is being quieted: #{default_quiet_backtrace}"
  end

  def cleaner
    defined?(MiniTest) ? MiniTest : self
  end
end
