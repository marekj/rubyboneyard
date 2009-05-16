require 'spec/autorun'
Spec::Runner.configure do |config|
  
end
# make a class as a collection of scenarios execute itself as rspec ExampleGroup
 
class UseCase
  attr_accessor :scenario
  
  def initialize
    @scenario = [:do_this, :do_that]
  end
  
  def do_this
    #puts 'this'
    'this'.should == 'this'
  end
  
  def do_that
    #puts 'that'
    'that'.should == 'that'
  end
  
  def do_some_other
    #puts 'some other'
    'some'.should == 'somea'
  end
  
  def run_as_rspec
    uc = self
    describe "#{uc.class.to_s}" do
      context "context" do
        uc.scenario.each do |sc|
          it "#{sc}" do
            uc.send sc
          end
        end
      end
    end
  end
end
 
uc = UseCase.new
uc.run_as_rspec
#uc.scenario = [:do_some_other];uc.run_as_rspec
#uc.do_some_other #no as rspec
uc.scenario = [:do_this]
uc.run_as_rspec

#uc.scenario = [:do_this]
#uc.run_as_rspec


## The Specs
# 
#require File.dirname(__FILE__) + "/spec_helper"
#require File.dirname(__FILE__) + "/../lib/use_case"
# 
# 
#describe UseCase do
#  context 'when first init' do
#    
#    before :each do
#      @uc = UseCase.new
#    end
#    
#    it 'has given scenario' do
#      @uc.run_as_rspec #.should be(Spec::Example::ExampleGroup::Subclass_2)
#    end
#    
#    it 'has no scenario add example to the group anyway' do
#      @uc.scenario = [:do_some_other]
#      #@uc.run_as_rspec.should be(Spec::Example::ExampleGroup::Subclass_3)
#      @uc.run_as_rspec
#    end
#    
#    it 'provide scenario' do
#      @uc.scenario = [:do_this, :do_that, :do_some_other]
#      @uc.run_as_rspec
#    end
#    
#  end
#end