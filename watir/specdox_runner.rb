
require 'watir/testcase' #test unit from watir for sequential

require 'spec/expectations' # rspec

class Watir::TestCase
  include Spec::Matchers # rspec matchers
end



class TestTest < Watir::TestCase
  def test_1
    2.should == 2
  end
  def test_2
    'hello'.should_not == 'bye'
  end
end

#require 'test/spec'
#require 'test/spec/dox' #custom formatter
#Test::Unit::UI::SpecDox::TestRunner.run TestTest
require 'test/unit/ui/console/testrunner'
Test::Unit::UI::Console::TestRunner.run TestTest

