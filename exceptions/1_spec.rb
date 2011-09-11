require 'rspec/autorun'

class Foo
  def foo
    caller 0 # array includes this line
  end
  def foo2
    caller # array does not include this line
  end

  def foo3
    caller.first
    #caller[0] #only where call came from, does not include this line
  end

end
describe "caller" do

  before :all do
    @c = Foo.new
  end

  it "bla" do
    pp @c.foo3
  end


  it "exception" do
    $!.should be_nil
  end


end
