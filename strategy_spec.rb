# Chapter 4. Replacing the Algorithm with the Strategy (Design Patterns in Ruby, Russ Olsen)
require 'spec/autorun'

class ContextAcceptingProc

  def initialize(&strategy)
    @strategy = strategy
  end

  def execute
    @strategy.call(self)
  end

  def some_method
    'I am some method from context'
  end

  def something_else
    'I am something else in context'
  end
end

STRATEGY_01 = lambda do |context|
  context.some_method
end

STRATEGY_02 = lambda do |context|
  context.something_else
end

describe "Context Accepting Proc for Strategy. Strategy call on on Context to do the work" do
  specify "strategy1" do
    context = ContextAcceptingProc.new(&STRATEGY_01)
    context.execute.should == 'I am some method from context'
  end

  specify "strategy2" do
    context = ContextAcceptingProc.new(&STRATEGY_02)
    context.execute.should == 'I am something else in context'
  end
end
