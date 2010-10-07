require 'spec/autorun'

Spec::Runner.configure do |runner|
  runner.append_before(:all) do
    @x = "new"
  end
end

context "x an instance var defined append_before :all block" do

  specify 'x is accessible' do
    @x.should == 'new'
  end

  specify 'x can be modified in example' do
    @x.should == 'new'
    @x = 'notnewnomore'
    @x.should == 'notnewnomore' #modified only in the scope of this example
  end
  specify 'but x modified in previous example is not modified in next example. each example uses the same x' do
    #does not bleed from previous example into next example. this example uses prestine x defined in before :all
    @x.should == 'new'
  end
end

context "xyz2 1b" do
  specify "x" do
    @x.should == 'new'
  end
end


