require 'spec/autorun'


describe "pending example" do
  it 'pend on failure' do
    pending 'pending when block fails expectation' do
      1.should == 2
    end
  end
  it 'pend on exception' do
    pending "pending when block throws exception" do
      "bla".should == foo
    end
  end

  it 'pend on error' do
    pending 'block errors' do
      z.should be_true
    end
  end

  it "pend with passing example should report FIXED and fail" do
    pending 'pending should fail when block passes' do
      1.should == 1
    end
  end

  it 'catch exception no matter what' do
    begin
      always_return_green
    rescue
      1.should == 1
      puts "hello. I am after rescue"  # this will execute
    end
  end


end
