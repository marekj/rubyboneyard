require 'spec/autorun'

describe "Houses Riddle" do

  before :all do

    @riddle =[
        {:color => 'red', :owner => 'Englishman'},
        {:color => nil, :owner => 'Spaniard', :pet => 'dog'},
        {},
        {},
        {}]
    @f1     = {:color => 'red', :owner => 'Englishman'}
    @f2     = {:owner => 'Spaniard', :pet => 'dog'}
    @f3     = {:color => 'green', :drink => 'coffee'}
    @f4     = {:owner => 'Ukrainian', :drink => 'tea'}
    @f5     = {:color => 'ivory'}
    @f6     = {:position => [@f5, @f3]}
    @f7     = {:smokes => 'Old Gold', :pet => 'snails'}
    @f8     = {:smokes => 'Kools', :color => 'yellow'}
    @f9     = {:position => 3, :drink => 'milk'}
    @f10    = {:owner => 'Norwegian', :position => 1}

  end

  it 'There are five houses' do
    @riddle.size.should == 5
  end

  it 'The Englishman lives in the red house' do
    @f1[:color].should == 'red'
    @f1[:owner].should == 'Englishman'
  end

  it 'The Spaniard owns the dog' do
    @f2[:pet].should == 'dog'
    @f2[:owner].should == 'Spaniard'
  end

  it 'Coffee is drunk in the green house' do
    @f3[:color].should == 'green'
    @f3[:drink].should == 'coffee'
  end

  it 'The Ukrainian drinks tea' do
    @f4[:owner].should == 'Ukrainian'
    @f4[:drink].should == 'tea'
  end

  it 'The green house is immediately to the right of the ivory house' do
    @f6[:position].map { |e| e[:color] }.should == ['ivory', 'green']
  end

  it 'The Old Gold smoker owns snails' do
    @f7[:smokes].should == 'Old Gold'
    @f7[:pet].should == 'snails'
  end

  it 'Kools are smoked in the yellow house' do
    @f8[:smokes].should == 'Kools'
    @f8[:color].should == 'yellow'
  end
  it 'Milk is drunk in the middle house' do
    @f9[:position].should == 3
    @f9[:drink].should == 'milk'
  end
  it 'The Norwegian lives in the first house' do
    @f10[:position].should == 1
    @f10[:owner].should == 'Norwegian'
  end

  it 'The man who smokes Chesterfields lives in the house next to the man with the fox' do
    @f11 = {:smoke => 'Chesterfields', :position => nil}
  end
  it 'Kools are smoked in the house next to the house where the horse is kept' do
    @f12
  end
#  it 'The Lucky Strike smoker drinks orange juice'
#  it 'The Japanese smokes Parliaments'
#  it 'The Norwegian lives next to the blue house'
end
