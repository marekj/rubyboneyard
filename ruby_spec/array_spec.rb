require 'spec/autorun'

=begin
a = [1,2,3,4,5,6]
r = a.select {|x| x%2==0} #=> [2, 4, 6]
# select is find_all {|element| such that element test returns true}s
r = a.map{|x| x%2==0}#=> [false, true, false, true, false, true]

the difference between select and map methods
in map method the expression x%2==0 returns the value of the expression true and false
and stores it in place for each element

in select method the same expression is a test for element true or false. if it is true the element is returned and if false the element is rejected
so, select returns element if expression is true while map returns the value of expression as element

=end

# Enumerate the same array with the same expression using different methods.

describe 'using the same array object to demonstrate array methods' do
  
  before :each do
    @a = [1,2,3,4,5,6] #test array methods on this array a
  end
  
  it 'select method returns elements for which test is true' do
    r = @a.select {|x| x%2==0}.should == [2,4,6] #=> [2, 4, 6]
  end
  
  it 'reject method returns elements for which test is not true' do
    r = @a.reject {|x| x%2==0}.should == [1,3,5] #=> [1, 3, 5]
  end
  
  it 'partition method is like doing select and reject at the same time. it returns two sets of elements, first for which test is true and second for which test is false' do
    r = @a.partition {|x| x%2==0}.should == [[2,4,6],[1,3,5]] #=> [1, 3, 5]
  end
  
  it 'map method returns values returned from expression on each element' do
    r = @a.map{|x| x%2==0} # => [false, true, false, true, false, true]
    r.should ==  [false, true, false, true, false, true]
  end
  
  it 'find method returns the first element for which test is true' do
    r = @a.find {|x| x%2==0}.should == 2 #=> 2
  end
  
end

describe 'words in array' do
  
  before :each do
    @words = %w[a bla c bla d e fa ga blabla blaaa dada]
  end
  
  it 'partition words based on condition' do
    r = @words.partition { |e| e[0,1] == 'b' }
    r.should == [["bla", "bla", "blabla", "blaaa"], ["a", "c", "d", "e", "fa", "ga", "dada"]]
  end
  it 'sort by length' do
    r = @words.sort_by {|e| e.length}
    r.should == ["a", "d", "c", "e", "ga", "fa", "bla", "bla", "dada", "blaaa", "blabla"]
  end

end
