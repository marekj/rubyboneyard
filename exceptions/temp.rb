require 'pp'

class MyError < StandardError
end





class Foo


  def foo
    fail MyError, 'my error dude'
    require 'blabla'
  rescue MyError, LoadError => e #same as $!
    pp 'in resuce'
    pp e
  ensure
    pp 'in ensure'
    #return 'bla' returns 'bla' from method instead of expected nil
  end
end



c = Foo.new
pp c.foo

