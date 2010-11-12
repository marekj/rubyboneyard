require File.dirname(__FILE__) + "/spec_helper"

module Outer

  def outer
    'outer'
  end

  define_method :genouter do |arg|
    "#{arg}genouter"
  end

  (class << self;self;end).class_eval do
    define_method :def_outer do
      puts "defined outer"
    end
  end

#  (class << self; self; end).class_eval do
#    define_method :def_outer do |what|
#      what
#    end
#  end
end

class Client
  # include module methods in eigenclass
  class << self
    include Outer
  end
end


class ClientTwo
  class << self
    include Outer
  end
end

describe 'Client' do
  it 'outer' do
    Client.outer.should == 'outer'
  end
  it 'genouter' do
    Client.genouter("hi").should == 'higenouter'
  end
end

describe "ClientTwo" do
  it 'redef' do
    Client2.outer.should == ""
  end
end
