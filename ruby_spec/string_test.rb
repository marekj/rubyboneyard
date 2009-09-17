require File.dirname(__FILE__) + "/spec_helper"

# ruby does not have each char for iterating on string.
# string.each_byte returns number. number.chr returns char. Shortuct is to build a each_char method.
class String
  def each_char
    each_byte {|b| yield b.chr }
  end
end


describe 'string' do
  before do
    @word = 'maja'
    @word_as_bytes = [109, 97, 106, 97]
    @word_as_chars = ['m','a','j','a']
  end
  
  it 'each byte turn into char' do
    as_chars = []
    @word.each_byte {|c| as_chars << c.chr}
    as_chars.should == @word_as_chars
  end
  
  it 'each byte' do
    as_bytes = []
    @word.each_byte {|b| as_bytes << b}
    as_bytes.should == @word_as_bytes
  end
  
  it 'each_char method added to string' do
    chars =[]
    @word.each_char {|c| chars << c}
    chars.should == @word_as_chars
  end
  
end


