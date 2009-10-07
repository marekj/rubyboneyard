require File.dirname(__FILE__) + '/testunit_space_spy'

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

#puts 'before tests'
require 'test/unit/ui/console/testrunner'

round1 = Test::Unit::SpaceSpy.tests
round1.each {|test| Test::Unit::UI::Console::TestRunner.run(test) }
