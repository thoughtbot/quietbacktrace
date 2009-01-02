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

    class Test::Unit::TestCase
  	  
    end

Filters modify the output of backtrace lines. Create your own:

    class Test::Unit::TestCase
      
    end

Turn Quiet Backtrace off anywhere in your test suite by setting the flag to false:

    Test::Unit::TestCase.quiet_backtrace = false

Rails-specific usage
--------------------

Because Quiet Backtrace works by adding attributes onto Test::Unit::TestCase,
you can add and remove silencers and filters at any level in your test suite,
down to the individual test. 

Requirements
------------

* Test::Unit 

Resources
---------

* [mailing list](http://groups.google.com/group/quiet_backtrace)
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
