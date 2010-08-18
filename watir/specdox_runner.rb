require 'watir/ie'
require 'watir/testcase' #test unit from watir for sequential

require 'spec/expectations' # rspec

class Watir::TestCase
  include Spec::Matchers # rspec matchers
end



class TestTest < Watir::TestCase
	@@ie = nil

	def browser
		@@ie ||=Watir::IE.attach(:url, /.*/)
	end

  def test_1
		browser.goto "http://watir.com"
    2.should == 2
  end

  def test_2
    'hello'.should_not == 'bye'
		verify_match "Web Application Testing in Ruby", browser.text
	  verify browser.title == 'Watir'
		verify_equal browser.title, 'Watir'
		verify_match 'watir.com', browser.link(:text, 'Home').href
  end
end

#require 'test/spec'
#require 'test/spec/dox' #custom formatter
#Test::Unit::UI::SpecDox::TestRunner.run TestTest
require 'test/unit/ui/console/testrunner'
Test::Unit::UI::Console::TestRunner.run TestTest

