require File.dirname(__FILE__) + "/spec_helper"

describe 'regexp matching' do
  
  it 'has captures' do
    # any two chars before numbers
    # follwed by number plus more numbers (not including the last number which goes into last capture)
    # ending with number # the post_match must begin with non number
    m = /(.)(.)(\d+)(\d)/.match("THX1138: The Movie")

    # pattern and captures
    m.to_a.should == ["HX1138", "H", "X", "113", "8"]

    m.captures.should == ["H", "X", "113", "8"]
    
    # pattern
    m.to_s.should == 'HX1138'
    $&.should == 'HX1138'

    $1.should == "H"
    $2.should == "X"
    $3.should == "113"
    $4.should == "8"

    m.pre_match.should == 'T'
    m.post_match.should == ': The Movie'
    $`.should == 'T'
    $'.should == ': The Movie'
  end

  it "any char plus (as greedy) matches up to last occurance of f char" do
    m = /bc.+f/.match "abcdeffffff"
    m.to_s.should == 'bcdeffffff'
  end

  it "any char plus (as non greedy) matches up to first occurance of f char" do
    m = /bc.+?f/.match "abcdeffffff"
    m.to_s.should == 'bcdef'
  end

  
  it 'repeats' do
    string = "My phone number is (123) 555-1234."
    phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
    m = phone_re.match(string) 
  end
  
  it 'positive lookahead' do 
    s = "abc def. ghi"
    m = /\w+(?=\.)/.match(s)
    m.to_a.should == ['def']
    
    m = /\w+(?=\s)/.match(s)
    m.to_a.should == ['abc']
  end
  
  it 'negative lookahead' do
    s = "abc def. ghi"  
    m = /\w+(?!\.)/.match(s)
    m.to_a.should == ['abc']
  end

end
