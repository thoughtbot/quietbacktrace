module QuietBacktrace
  class Cleaner
    
    RUBY_DIRS      = %w( ruby Ruby.framework )
    TEST_UNIT_DIRS = %w( test/unit )
    GEM_NOISE      = %w( -e:1 )
    
    NOISE = RUBY_DIRS + TEST_UNIT_DIRS + GEM_NOISE
    
    def initialize
      @filters, @silencers = [], []
      
      add_silencer { |line| NOISE.any? { |dir| line.include?(dir) } }
      
      # self.quiet_backtrace = true
    end
    
    # Returns the backtrace after all filters and silencers has been run against it. Filters run first, then silencers.
    def clean(backtrace)
      silence(filter(backtrace))
    end
 
    # Adds a filter from the block provided. Each line in the backtrace will be mapped against this filter.
    #
    # Example:
    #
    # # Will turn "/my/rails/root/app/models/person.rb" into "/app/models/person.rb"
    # backtrace_cleaner.add_filter { |line| line.gsub(Rails.root, '') }
    def add_filter(&block)
      @filters << block
    end
 
    # Adds a silencer from the block provided. If the silencer returns true for a given line, it'll be excluded from the
    # quiet backtrace.
    #
    # Example:
    #
    # # Will reject all lines that include the word "mongrel", like "/gems/mongrel/server.rb" or "/app/my_mongrel_server/rb"
    # backtrace_cleaner.add_silencer { |line| line =~ /mongrel/ }
    def add_silencer(&block)
      @silencers << block
    end
 
    # Will remove all silencers, but leave in the filters. This is useful if your context of debugging suddenly expands as
    # you suspect a bug in the libraries you use.
    def remove_silencers!
      @silencers = []
    end
    
    private
    
      def filter(backtrace)
        @filters.each do |f|
          backtrace = backtrace.map { |line| f.call(line) }
        end
        
        backtrace
      end
      
      def silence(backtrace)
        @silencers.each do |s|
          backtrace = backtrace.reject { |line| s.call(line) }
        end
        
        backtrace
      end
  end
  
  # For installing the Cleaner in test/unit
  module CleanerForTestUnit #:nodoc:
    def self.included(klass)
      klass.send :alias_method, :filter_backtrace_without_cleaning, :filter_backtrace
      klass.send :alias_method, :filter_backtrace, :filter_backtrace_with_cleaning
    end

    def filter_backtrace_with_cleaning(backtrace)
      backtrace = filter_backtrace_without_cleaning(backtrace)
      backtrace = backtrace.first.split("\n") if backtrace.size == 1
      cleaner = QuietBacktrace::Cleaner.new 
      cleaner.clean(backtrace)
    end
  end
end
