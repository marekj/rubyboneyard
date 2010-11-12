require 'spec/autorun'

#unconventional grouping of shared examples by Capitalized symbol
# allows you to use include SomeShare instead of it_should_behave_like
share_as :SomeShare do
  it 'should share' do
    1.should == 1
  end
end

share_as "SomeStringShare" do
 it 'should be string' do
   'p'.should == 'f'
 end
end

shared_examples_for "someshare" do
  it "should share this and fail" do
    3.should == 3
  end
end

describe "container" do
  include SomeShare    # instead of it_should_behave_like
  it 'should not share' do
    2.should == 2
  end
end

describe "container2" do
  it_should_behave_like 'someshare' # string matching example group
  it_should_behave_like SomeShare # Constant
  it_should_behave_like "SomeStringShare"

  it "should pass in container" do
    'p'.should == 'p'
    end
end
