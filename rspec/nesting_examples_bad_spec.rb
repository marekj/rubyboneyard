require 'spec/autorun'

=begin
This is illegal usage of rspec
NoMethodError: undefined method `it' for #<Spec::Example::ExampleGroup::Subclass_1:0x341cb68>
=end
describe 'Some Group' do
  it "should have this passing example" do
    1.should == 1
    it "should have nested passing example" do
      2.should == 2
    end
  end
end

