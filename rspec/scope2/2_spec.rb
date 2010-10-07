require 'spec/autorun'

context "x an instance var defined by method in example group block" do

  def x
    @x ||= 'new'
  end

  def x=(v)
    @x=v
  end

  specify "x is accessible after it's initialized by method call" do
    x.should == 'new'
    @x.should == 'new' #access directly
  end

  specify 'x was init by previous example but not accessible in this example. is changed inside example' do
    @x.should be_nil
    x.should == 'new'
    @x.should == 'new'
    x = 'notnewnomore'
    x.should == 'notnewnomore'
    @x.should == 'new' #not changed by x= method. Why?
  end

  specify 'x modified in previous example is not available here' do
    @x.should be_nil
    x.should_not == 'notnewnomore'
  end
end
