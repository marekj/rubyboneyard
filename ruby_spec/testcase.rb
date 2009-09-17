require 'test/unit'
class TestCaseExample < Test::Unit::TestCase
  def test_1
    assert_equal 3, 3
  end
  
  def test_2
    assert_equal "blabl", "blabla"
  end
  
  def test_3
     
    flunk "I am broken. Fix me"
  end
end