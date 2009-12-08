require 'spec/autorun'

# test/spec examples from 
# http://innig.net/software/ruby/closures-in-ruby.rb
# CLOSURES IN RUBY by Paul Cantrell


class Foo
  
  def self.thrice
    yield
    yield
    yield
  end

  
  def self.thrice_with_local_x
    x = 100
    yield
    yield
    yield
    x
  end

end


describe 'Blocks are like closures, because they can refer to variables from their defining context' do
  
  it 'init integer out of scope and return yieled value' do
    x = 5
    res = Foo.thrice do
      x += 1
    end
    res.should == 8
    x.should == 8
  end    
  
  it 'init string out of scope and return yielded value' do
    x = 'ab'
    res = Foo.thrice do
      x += 'ab'
    end
    res.should == 'abababab'
    x.should == 'abababab'
  end
  
end

describe 'A block refers to variables in the context it was defined, not the context in which it is called' do

  it 'a' do
    x = 5
    result_from_block = Foo.thrice_with_local_x do
      x += 1
    end
    result_from_block.should == 100 # local x inside the block
    x.should == 8 # yield calculates the called x from outer scope
  end

end


describe 'A block only refers to *existing* variables in the outer context' do
  
  it 'block does not create outer context when it is defined in the block' do
    res = Foo.thrice do
      xyz = 'xyz'
      true if defined? xyz
    end
    res.should be_true # xyz was defined in the block
    defined?(xyz).should be_nil # xyz does not exist outside of block
  end
  
  it 'block does not create outer context when it is defined in the block' do
    xyzz = 'xyzz outside'
    res = Foo.thrice do
      xyzz = 'xyzz inside'
      true if defined?(xyzz)
    end
    res.should be_true
    xyzz.should == 'xyzz inside'
    defined?(xyzz).should == 'local-variable(in-block)'
  end
  
end