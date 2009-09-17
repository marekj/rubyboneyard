require File.dirname(__FILE__) + "/spec_helper"
# Be careful with class attributes. They are like globals
# A Subclass can change it 
# it is better to use a Eigenclass Attriubtes which belongs to the class object

# why I don't like @@attributes
# Stuart Halloway examples

class Base
  @@shared = 'cattr from base' #class attribute
  
  class << self
    attr_accessor :unshared #eigenclass attribute
  end
  
  def self.shared
    @@shared
  end
  self.unshared = 'attr from base' #initialize eigenclass attribute
end

class Derived < Base
  @@shared = 'cattr from derived' #overwrites value in all classes
  self.unshared = 'attr from derived' #init eigenclass attribute for the Class Object only
end


describe "attributes after subclassing" do
  
  it 'eigenclass attribute is not overwritten by subclass' do
    Base.unshared.should == 'attr from base'
    Derived.unshared.should == 'attr from derived'
  end
  
  it 'class attribute is overwritten by subclass' do
    Derived.shared.should == 'cattr from derived'
    Base.shared.should == 'cattr from derived'
  end
end


class Ouch
  
  class << self
    attr_accessor :unshared
  end
  def self.shared
    @@shared
  end
end


describe 'accessing uninitialized attributes' do 
  it 'class attribuute access raises NameError' do
    lambda{Ouch.shared}.should raise_error(NameError)
  end
 
  it 'eigenclass attribute access returns nil' do
    Ouch.unshared.should be_nil
  end
end
