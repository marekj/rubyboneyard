require File.dirname(__FILE__) + "/spec_helper"

describe 'operate on range' do
  
  it 'partitions like array' do
    dozen = (1..12)
    r=dozen.partition { |e| e % 2 == 0 }
    r.should == [[2, 4, 6, 8, 10, 12], [1, 3, 5, 7, 9, 11]]
  end
  
end
