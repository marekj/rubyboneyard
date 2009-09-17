require File.dirname(__FILE__) + "/spec_helper"


# example of mechanism for generating PageObjects
module PageFaces
  module ClassMethods
    def face_a(name, &block)
      define_method(name, block)
    end
    
    def face_b(name, defin)
      string_eval = "def #{name}; " +
                    "  #{defin.inspect}; " + 
                    "end; "
      module_eval string_eval
    end
  end
  def self.included(receiver)
    receiver.extend(ClassMethods)
  end
end

module Ma #container for page objects to be mixed in to Page subclass
  include PageFaces
  face_a :ma do
    "mama"
  end
  face_b :mab, "mamab"

end

class Page # PageObjects container BASE
  include PageFaces 
  face_a :po do
    self
  end  
end
  
class Pa < Page #Subclass of Page
  include Ma
  face_a :pa do
    'papa'
  end
  face_b :pab, self
  face_b :pac, [:elem1, :elem2, :elem3]
  face_a :baca do
    [:elem1, :elem2, :elem3]
  end
end


describe "Pa face_b method creation " do
  
  before :each do
    @pa = Pa.new
  end
  
  it 'bla' do
    @pa.mab.should == 'mamab'
    @pa.pab.should == Pa
  end
end


describe "Pa methods available" do

  before :each do
    @pa = Pa.new
  end

  it 'Ma.ma method should raise error' do
   lambda{Ma.ma}.should raise_error(NoMethodError)
 end
 
 it 'pa inherits ma from Ma module definition' do
   @pa.ma.should == 'mama'
 end
 
 it 'Pa has pa method defined' do
   @pa.pa.should == 'papa'
 end
 
  it 'Pa inherits from Page class ' do
   @pa.po.should be_instance_of(Pa)
 end
 
 it "Pa has face_a method to define more methods" do
   Pa.face_a :bla do # do I want to do this? inject methods into already existing object?
     'bla'
   end
   @pa.respond_to?(:bla).should be_true
   @pa.bla.should == 'bla'
 end

end
