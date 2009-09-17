require File.dirname(__FILE__) + "/spec_helper"

class PageDefine
  class << self
    def definitions
      @definitions ||= {}
      
    end
    def define(label,&suitcase)
      self.definitions[label] = suitcase
    end
  end
  def initialize
    create_interfaces
  end
  private
  def create_interfaces
    self.class.definitions.each do |label, suitcase|
      self.class.class_eval do
        define_method(label, &suitcase)
      end
    end
  end
end

describe "PageDefine" do
  
  it 'has no definitions by itself' do
    PageDefine.definitions.should == {}
  end
 
  it 'when initialized has no local methods' do
    PageDefine.new.local_methods.should == []
  end
  
  it 'had define method for deining interfaces ' do
    class PageDefineA < PageDefine
      define :foo do
        'foo'
      end
    end
    # This is Bad desing because you can access definitions from outside and alter them. 
    # Bad Leakage. You should not do this
    PageDefineA.definitions.has_key?(:foo).should be_true
    PageDefineA.definitions[:foo] = 'blabla'
    PageDefineA.definitions.should == {:foo => 'blabla'}
    
  end
  
  
end
#
#class SubPageDefine < PageDefine
#  define(:that) {'thatthing'}
#  def mthat
#    'def methodname'
#  end
#end
#
#class SubSubPageDefine < SubPageDefine
#  define(:this) {'thisthing'}
#end
#
#page = SubSubPageDefine.new
#puts page.mthat.inspect
#puts page.this.inspect
##puts page.that # this is not known to the page
#puts page.inspect
#
#class Bla
#  def initialize
#    @page = SubPageDefine.new
#  end
#  def talk
#    puts @page.inspect
#  end
#end
#
#b = Bla.new
#b.talk
#b.mthat
#
#describe SubPageDefine do
#  it 'faces' do
#    page = SubPageDefine.new
#    page.definitions.keys.should == [:this]
#    page.definitions.values.should == ['blabla']
#    
#  end
#end
#
##
##class MultiObjectPageDefine < SubPageDefine
##  define(:that, 'blablabla')
##end
##
##
##describe MultiObjectPageDefine do
##  it 'has faces' do
##    page = MultiObjectPageDefine.new
##    page.interfaces.keys.should == [:this, :that]
##  end
##end
##
