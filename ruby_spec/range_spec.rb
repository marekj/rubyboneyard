require 'spec/autorun'

describe 'operate on range' do
  
  it 'partitions like array' do
    dozen = (1..12)
    r = dozen.partition { |e| e % 2 == 0 }
    r.should == [[2, 4, 6, 8, 10, 12], [1, 3, 5, 7, 9, 11]]
  end

  it 'subset contained in range' do
    superset = (4..22)
    subset = (7..12)
    ((superset.first <= subset.first) and (subset.last <= superset.last)).should be_true
  end

  it 'subset not contained in range' do
    superset = (4..22)
    subset = (2..12)
    ((superset.first <= subset.first) and (subset.last <= superset.last)).should be_false
  end

  it 'subset not contained in range2' do
    superset = (4..22)
    subset = (7..27)
    ((superset.first <= subset.first) and (subset.last <= superset.last)).should be_false
  end

end
