require 'spec/autorun'

module A
  def self.foo
    self
  end
  def bar #when class extends this becomes class method
    self
  end
end

class AA
  extend A
end

class BB
  include A
end

describe 'Class definition has extend module' do
  it 'bar method becomes class method' do
    AA.respond_to?(:bar).should be_true
    AA.bar.should be(AA) # returns Class self
    A.foo.should be(A)
  end
  
  it 'and new instance of class does not have method bar' do
    aa = AA.new
    aa.respond_to?(:bar).should be_false
  end
  
  it 'self.foo method is not know as class method ' do
    AA.respond_to?(:foo).should be_false
  end
  
  it 'and self.foo method is not known as instance method' do
    aa = AA.new
    aa.respond_to?(:foo).should be_false
  end
end

describe 'Class definition has include module' do
  it 'bar method is not know as class method' do
    BB.respond_to?(:bar).should be_false
  end
  it 'bar method becomes class instance method' do
    bb = BB.new
    bb.respond_to?(:bar).should be_true
    bb.bar.should be_instance_of(BB)
  end
  
  it 'self.foo method is not know to the class' do
    BB.respond_to?(:foo).should be_false
  end
  
  it 'self.foo method is not know to the instance of class' do
    bb = BB.new
    bb.respond_to?(:foo).should be_false
  end
end


