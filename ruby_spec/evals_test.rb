require File.dirname(__FILE__) + "/spec_helper"

class Foo
  @@a = 'a'
  def self.sing
    @@a
  end
  
  def inst
    @@a
  end
end

# redefine class var in class eval block
Foo.class_eval do
  @@a = 'b'
end
    
#f = Foo.new #make instance before class_eval

#Foo.class_eval do
#  @@a = 'b' #redefines value for singleton class object but not up to the class var in class Foo
#  puts @@a #=> b
#end

#f.instance_eval do 
#  puts @@a #=> 'b'
#end
#puts Foo.sing #=> 'a' calls the original Foo class and uses class var

describe 'redefined class var using class_eval' do
  
  it 'is not visible to class method' do
    Foo.sing.should == 'a' #original
  end
  it 'is not visible to instance method' do
    Foo.new.inst.should == 'a' #original 
  end
  
  it 'is visible to instance eval context but not instance object' do
    x = ''
    f = Foo.new
    f.instance_eval do
      x = @@a
    end
    x.should == 'b'
    f.inst.should == 'a'
  end
  
  it 'is visible to outer scope but class method returns original' do
    x = ''
    Foo.class_eval do
      @@a = 'c'
      x = @@a
    end
    x.should == 'c' # outer scope get from class eval
    Foo.sing.should == 'a' #original value returned
  end
  
end