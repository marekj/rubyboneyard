require File.dirname(__FILE__) + "/spec_helper"

class Top
  attr_reader :top, :down
  def initialize
    @top = 'init at top' 
  end
end

class Down < Top
  def initialize(what)
    super() # this is correct. super expects NO args. 
    @down = what
  end
end

class Downb < Down
  def initialize(whata)
    super #this passes whata up to Down class
  end
end

class Down2 < Down
  def initialize
    super('down2')
  end
end

class Down2b < Top
  def initialize(what)
    super #this will throw exception. should be super()
    @down = what
  end
end

describe 'init subclass with one param calls super' do
  it 'super with () passes no args up' do
    o = Down.new "hellopotus"
    o.top.should == 'init at top'
    o.down.should == 'hellopotus'
  end
  
  it 'super(arg) passes up the args from subclass' do
    o = Down2.new
    o.top.should == 'init at top'
    o.down.should == 'down2'
  end
  
  it 'calling super which expects no args with naked super call blows up' do
    lambda{Down2b.new}.should raise_error(ArgumentError)
  end
  
  it 'super with noting after it delegates args from initialize up to parent' do
    o = Downb.new 'passmeup'
    o.down.should == 'passmeup'
  end
  
end
