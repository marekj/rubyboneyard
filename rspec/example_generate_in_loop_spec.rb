require 'spec/autorun'

describe 'Examples generated by iterator can coexist with regular example blocks in the same group' do
  it "should first" do
    1.should == 1
  end

  1.upto(3) do |i|
    it "should #{i}" do
      i.should == i
    end
  end

  it "should last" do
    'last'.should == 'last'
  end
end




