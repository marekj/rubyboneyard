require File.dirname(__FILE__) + "/spec_helper"

describe 'regexp matching' do
  
  it 'has captures' do
    m = /(.)(.)(\d+)(\d)/.match("THX1138: The Movie")
    m.to_a.should == ["HX1138", "H", "X", "113", "8"]
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
