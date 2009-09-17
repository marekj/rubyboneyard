# using test/spec behave type methods in TestUnit classes
require 'test/spec'
require 'watir/testcase'

class TC_me < Watir::TestCase
  def test_me
    'bla'.should == 'bla'
    puts "TC_me_me"
  end
  def test_you
    1.should.be 1
    puts 'TC_me_you'
  end
end

class TC_abc < Watir::TestCase
  def test_bla  
    true.should.be true
    puts "TC_wow_bla"
  end
  def test_yay
    false.should.be false
    puts "TC_wow_yay"
  end
end

# test spec class will also be picked up by the spy
describe 'HelloWorld Context Name' do
  it 'the it method' do
    true.should.be true
    puts 'context_it'
  end
  it 'some other thing' do
    true.should.be true
    puts 'context_other'
  end
end

class TC_wow < Watir::TestCase
  def test_bla  
    true.should.be true
    puts "TC_wow_bla"
  end
  def test_yay
    false.should.be false
    puts "TC_wow_yay"
  end
end


require File.dirname(__FILE__) + '/test_unit_space_spy'
# get the yaml representation of all TestCases loaded in ObjectSpace
#puts 'Watir TestCases to Run'
#p Test::Unit::SpaceSpy.tests
#p Test::Unit::SpaceSpy.to_a
#exit
#
#out =[]
#tests.each do |test|
#  rec =[];rec << test.name
#  srec = [];test.tests.each {|tm| srec << tm.method_name};rec << srec
#  out << rec
#end
#p out
  

#exit

#p TestSpaceSpy.to_a
#puts TestSpaceSpy.to_yaml
#require 'test/unit/collector/objectspace'
#ts = Test::Unit::Collector::ObjectSpace.new.collect
#out = []
#ts.tests.each do |test|
#  rec =[];rec << test.name
#  srec = [];test.tests.each {|tm| srec << tm.method_name};rec << srec
#  out << rec
#end
#p out
#
#exit

class TC_testspacespy < Test::Unit::TestCase
  
  def test_to_a
    Test::Unit::ObjectSpaceSuite.to_a.should == [
      ["TC_me", ["test_me", "test_you"]], 
      ["TC_abc", ["test_bla", "test_yay"]], 
      ["HelloWorld Context Name", ["test_spec {HelloWorld Context Name} 001 [the it method]", "test_spec {HelloWorld Context Name} 002 [some other thing]"]], 
      ["TC_wow", ["test_bla", "test_yay"]],
      ["TC_testspacespy", ["test_to_a", "test_to_yaml"]]
    ]
  end
  
  def test_to_yaml
    ydoc =<<EOF
--- 
- - TC_me
  - - test_me
    - test_you
- - TC_abc
  - - test_bla
    - test_yay
- - HelloWorld Context Name
  - - test_spec {HelloWorld Context Name} 001 [the it method]
    - test_spec {HelloWorld Context Name} 002 [some other thing]
- - TC_wow
  - - test_bla
    - test_yay
- - TC_testspacespy
  - - test_to_a
    - test_to_yaml
EOF
    Test::Unit::ObjectSpaceSuite.to_yaml.should == ydoc
  end
end