require File.dirname(__FILE__) + "/spec_helper"

class Foobject
  @b = 'bee'
  def initialize(a)
    @a = a
  end
end


describe 'Finding about Object and variables' do

  before :each do
    @o = Foobject.new('bla')
  end
  
  it "instance var should be defined" do
    @o.instance_variable_defined?(:@a).should == true
    @o.instance_variables.should == ["@a"]
  end

  it 'getting value of instance var when no a accessor specified' do
    @o.instance_variable_get(:@a).should == 'bla'
  end
  
  it '@b is not defined for object' do 
    @o.instance_variable_get(:@b).should be_nil
  end
    
  it '@b is class instance variable' do
    Foobject.instance_variable_get(:@b).should == 'bee'
  end

end 