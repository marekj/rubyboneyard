require File.dirname(__FILE__) + "/spec_helper"

module Mixme
  module ClassMethods
    def foo
      self
    end
  end
  
  def self.included(receiver)
    receiver.extend(ClassMethods)
  end
  
  def bar
    self
  end
end

class Classme
  include Mixme #include here triggers extend on receiver
  def fooinclass
    self
  end  
end

describe "Class includes Module that triggers extend on receiver" do
  
  before do
    @cme = Classme.new
  end

  it 'foo is Classme class method' do
    Classme.respond_to?(:foo).should be_true
    Classme.foo.should be(Classme)
    @cme.respond_to?(:foo).should be_false
  end
  
  it 'bar is Classme instance method' do
    Classme.respond_to?(:bar).should be_false
    @cme.respond_to?(:bar).should be_true
  end


end


