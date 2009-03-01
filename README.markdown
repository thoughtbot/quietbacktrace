Quiet Backtrace
===============

Quiet Backtrace suppresses the noise in your Test::Unit backtrace.
It also provides hooks for you to add additional silencers and filters.

Install
-------

sudo gem install thoughtbot-quietbacktrace --source=http://gems.github.com

Usage
-----

Silencers remove lines from the backtrace. Create your own:

    # Will reject all lines that include the word "mongrel", 
    # like "/gems/mongrel/server.rb" or "/app/my_mongrel_server/rb"
    backtrace_cleaner = QuietBacktrace.BacktraceCleaner.new
    backtrace_cleaner.add_silencer { |line| line =~ /mongrel/ }

Filters modify the output of backtrace lines. Create your own:

    # Will turn "/my/rails/root/app/models/person.rb" into "/app/models/person.rb"
    backtrace_cleaner = QuietBacktrace.BacktraceCleaner.new
    backtrace_cleaner.add_filter { |line| line.gsub(Rails.root, '') }

Requirements
------------

* Test::Unit 

Resources
---------

* [project site](http://github.com/thoughtbot/quietbacktrace)

Authors
-------

* [Dan Croak](http://dancroak.com) 
* [James Golick](http://jamesgolick.com/) 
* [Joe Ferris](jferris@thoughtbot.com)

Special thanks to the [Boston.rb group](http://bostonrb.org)
for cultivating this idea at our inaugural hackfest. 

Copyright (c) Dan Croak, James Golick, Joe Ferris, thoughtbot, inc.
(the MIT license)
