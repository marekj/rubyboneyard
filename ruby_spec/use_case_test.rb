require File.dirname(__FILE__) + "/spec_helper"
require File.dirname(__FILE__) + "/../lib/use_case"


describe UseCase do
  context 'when first init' do
    
    before :each do
      @uc = UseCase.new
    end
  
    it 'has given scenario' do
      @uc.run_as_rspec #.should be(Spec::Example::ExampleGroup::Subclass_2)
    end
    
    it 'has no scenario add example to the group anyway' do
      @uc.scenario = [:do_some_other]
      #@uc.run_as_rspec.should be(Spec::Example::ExampleGroup::Subclass_3)
      @uc.run_as_rspec
    end
    
    it 'provide scenario' do
      @uc.scenario = [:do_this, :do_that, :do_some_other]
      @uc.run_as_rspec
    end
    
  end
end
