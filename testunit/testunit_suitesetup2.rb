require 'test/unit'

class TC_me < Test::Unit::TestCase
  def test_me
    puts "TC_me_me"
  end
  def test_you
    puts 'TC_me_you'
  end
end

class TC_abc < Test::Unit::TestCase
  def test_meb
    puts "TC_me_meb"
  end
  def test_youle
    puts 'TC_me_youle'
  end
end


# example from http://silkandspinach.net/2007/06/09/setup-and-teardown-for-a-ruby-testsuite/

require 'test/unit/testsuite'
class TS < Test::Unit::TestSuite
  
  def self.suite
    ts = self.new(self) # this has to be self.new and not TestSuite.new
    ts << TC_me.suite
    ts << TC_abc.suite
    ts
  end
  
  def setup
    puts 'setup suite to run tests'
  end
  
  def teardown
    puts 'teardown suite after tests'
  end
  
  def run(*args)
    setup
    super
    teardown
  end
  
end


require 'test/unit/collector/objectspace'

ts = Test::Unit::Collector::ObjectSpace.new.collect
out = []
ts.tests.each do |test|
  rec =[];rec << test.name
  srec = [];test.tests.each {|tm| srec << tm.method_name};rec << srec
  out << rec
end
p out

exit

require 'test/unit/ui/console/testrunner'
Test::Unit::UI::Console::TestRunner.run(TS)

# alternative is to run SpaceSpy to populate the tests but it is a one shot only affair
