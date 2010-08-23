require 'spec/autorun'

=begin
  http://avdi.org/devblog/2010/08/02/using-and-and-or-in-ruby/

and and or, despite an apparent similarity to && and ||, have very different roles.

and and or are control-flow modifiers like if and unless.
When used in this capacity their low precedence is a virtue rather than an annoyance.

and is useful for chaining related operations together until one of them returns nil or false

&& and || are boolean operators

=end


describe '&& and operators' do

  specify "&& precedence" do
    # 42 && foo is evaluated first
    lambda { foo = 42 && foo / 2 }.should raise_error(NoMethodError, "undefined method `/' for nil:NilClass")
    ((foo = 42) && (foo / 2)).should == 21
  end

  specify "and has lower precedence and chains expressions together" do
    (foo = 42 and foo / 2).should == 21
  end

  specify "&& and with nil" do
    (5 and nil).should == nil
    (5 && nil).should == nil
    (nil and 5).should == nil
    (nil && 5).should == nil
  end

  specify "&& and with false" do
    (5 and false).should == false
    (5 && false).should == false
    (false and 5).should == false
    (false && 5).should == false
  end

  specify "&& and with true" do
    (5 and true).should == true
    (5 && true).should == true
    (true and 5).should == 5
    (true && 5).should == 5
  end


end

describe "|| or operators" do
  specify 'or || with nil' do
    # chaining expressions. like series of fallbacks: try this, if that fails try this, and so on
    # You can also look at or as a reversed unless statement modifier:
    # these are the same
    (5 or nil).should == 5
    (5 || nil).should == 5
    (nil or 5).should == 5
    (nil || 5).should == 5
  end

  specify "or || with false" do
    (5 or false).should == 5
    (5 || false).should == 5
    (false or 5).should == 5
    (false || 5).should == 5
  end

  specify "or || with true" do
    (5 or true).should == 5
    (5 || true).should == 5
    (true or 5).should == true
    (true || 5).should == true
  end


end
