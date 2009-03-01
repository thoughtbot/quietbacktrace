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

gem_spec = Gem::Specification.new do |gem_spec|
  gem_spec.name        = "quietbacktrace"
  gem_spec.version     = "1.1.6"
  gem_spec.summary     = "Suppresses the noise in your Test::Unit backtraces."
  gem_spec.email       = "support@thoughtbot.com"
  gem_spec.homepage    = "http://github.com/thoughtbot/quietbacktrace"
  gem_spec.description = "Silence or filter lines of your backtrace programatically."
  gem_spec.authors     = ["thoughtbot, inc.", "Dan Croak", "James Golick", 
                          "Mike Burns", "Joe Ferris", "Boston.rb"] 
  gem_spec.files       = FileList["[A-Z]*", "{lib}/**/*"]
end

desc "Generate a gemspec file"
task :gemspec do
  File.open("#{gem_spec.name}.gemspec", 'w') do |f|
    f.write gem_spec.to_yaml
  end
end

