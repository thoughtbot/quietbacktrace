require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'date'

desc "Run the test suite"
task :default => :test

desc 'Test the quietbacktrace gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
