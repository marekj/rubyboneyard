require 'spec/autorun'

# build a class to demonstrate the Object send method
class Foosend
  attr_reader :a, :b
  
  def initialize
    @a = nil
  end
  
  def foo(arg='foo')
    @a = arg
  end

  def m1(arg0, arg1)
    @a, @b = arg0, arg1
  end
  
  def m2(arg0, *arg1)
    @a, @b = arg0, arg1
  end
end


describe 'Foosend' do
  
  before :each do
    @o = Foosend.new
  end
  
  it 'send m1 method with 2 args initializes attrs' do
    @o.send :m1, 'ala', 'bla'
    @o.a.should == 'ala'
    @o.b.should == 'bla'
  end

  it "send m1 array for arg1 and nothing for arg2 raises ArgumentError" do
    lambda{@o.send(:m1, ['ala', 'bla'])}.should raise_error(ArgumentError)
  end
  
  it "send m2 array for arg0 and nothing for *arg1 gets empty array" do
    @o.send :m2, ['ala', 'bla']
    @o.a.should == ['ala', 'bla']
    @o.b.should == []
  end

  it 'send foo no arg gets seeded with default' do
    @o.send :foo
    @o.a.should == 'foo'
  end
  
  it 'send foo with arg gets it and discards default' do
    @o.send :foo, 'yep'
    @o.a.should == 'yep'
  end
  
  it 'send foo broken up array with one element for arg0' do
    s = [:foo, 'yeppa']
    sym, *rest = s
    @o.send sym, rest
    @o.a.should == ['yeppa']
  end
  
  it 'send foo broken up array with many elements for arg0' do
    s = [:foo, 'yeppa','gappa', 'kikka']
    sym, *rest = s
    @o.send sym, rest
    @o.a.should == ['yeppa', 'gappa', 'kikka']
  end
  
end