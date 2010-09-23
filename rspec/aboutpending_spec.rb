require 'spec/autorun'


describe "pending example" do
  it 'has pending block that fails' do
    pending 'pending when block fails expectation' do
      1.should == 2
    end
  end
  it 'has pending block that throws exception' do
    pending "pending when block throws exception" do
      "bla".should == foo
    end
  end

  it "has pending block that passes" do
    pending 'pending should fail when block passes' do
      1.should == 1
    end
  end

  it 'catch exception no matter what' do
    begin
      always_return_green
    rescue
    end
  end


end
