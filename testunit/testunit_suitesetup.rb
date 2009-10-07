# http://groups.google.com/group/comp.lang.ruby/browse_thread/thread/4d0514db603958b3

require 'test/unit'

class T < Test::Unit::TestCase
  
  def setup
    p 'setup'
  end
  
  def teardown
    p 'teardown'
  end
  
  def test1
    p 'test1'
  end
  
  def test2
    p 'test2'
  end
  
  # overwrite the suite class method for this class object
  def self.suite
    s = super
    def s.setup
      p 'suite_setup'
    end
    
    def s.teardown
      p 'suite_teardown'
    end
    # run before all and after all and in between run the class tests methods
    def s.run(*args)
      setup
      super
      teardown
    end
    s
  end
  
end 

=begin
 how to do suite setup and teardown.
in test/spec it is 
before :all do
  puts 'suite setup'
end

after :all do
  puts 'suite tardown
end



=end


# see also 
# http://silkandspinach.net/2007/06/09/setup-and-teardown-for-a-ruby-testsuite/


class MySuite < Test::Unit::TestSuite
  
  def self.suite
    # provided test cases here
  end
  
  def setup
    puts 'for the whole suite'
  end
  
  def teardown
    puts 'for the whole suite'
  end
  
  def run(*args)
    setup
    super
    teardown
  end
end

require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner'
Test::Unit::UI::Console::TestRunner.run(T)
#Test::Unit::UI::Console::TestRunner.run(MySuite)