require 'spec/autorun'

=begin
generate examples inside the group can coexist with the regular example blocks

=end

describe 'Some Group' do
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




