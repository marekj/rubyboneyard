require 'spec/autorun'


describe "using inst var in examples" do
  before :all do
    @be_all = "I am from before all" #set instance var here
    puts "in before :all: #{self}"
  end
  
  it 'has access to before all scope' do
    puts "in example: #{self}"
    @be_all.should == 'I am from before all' #should be visible here
  end
end


describe "something2" do
  be_all = '' # this has to exist here. local var defined in this scope

  before :all do
    be_all = "I am from before all" #local var gets value
  end

  it 'has access to before all scope' do
    be_all.should == 'I am from before all' #local var accessible
  end

end



