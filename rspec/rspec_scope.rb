require 'spec/autorun'


describe "something" do
  before :all do
    @be_all = "I am from before all"
  end
  
  it 'has access to before all scope' do
    @be_all.should == 'I am from before all'
  end
end