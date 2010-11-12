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
  be_all = '' # must initialize local var in block used later to populate value

  before :all do
    be_all = "I am from before all" #local var gets value
  end

  it 'has access to before all scope' do
    be_all.should == 'I am from before all' #local var accessible
  end

end

# it's not what it is but what it will be after rspec generates examples to run
# we define rspec exemples here. they will then run.
# definition does note execute, definition defines examples then then they execute. comprende?
describe "constructing examples from local data in the block" do
  items = ['a', 'b', 'c']

  it 'verify' do
    items.should == ['a', 'b', 'c']
  end

  items.each do |i|
    it "#{i}" do
      i.should == i
    end
  end

end



