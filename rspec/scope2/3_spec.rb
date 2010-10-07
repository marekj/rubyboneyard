require 'spec/autorun'

context "x an instance var defined in example" do

  specify "x is accessible after it's initialized" do
    @x = 'new'
    @x.should == 'new'
  end

  specify 'x value is changed inside example' do
    @x.should be_nil
  end

end
