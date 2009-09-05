require File.dirname(__FILE__) + "/object_instance_exec"


module Page

  def self.method_added(facename)
    puts "method: #{facename}"
  end

  module ClassMethods
    def face(facename, *args, &block)
      define_method facename do |*args|
        instance_exec(*args, &block)
      end
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

end

class Bla
  include Page

  def self.method_added(facename)
    puts "method: #{facename}"
  end
  
  face(:bla) {|*args| puts args.inspect }

end


b = Bla.new
puts "defineme"
b.bla 'yo', 'other', 'more'
b.bla("hihi")


class Foo < Bla
  face(:foo) {|args| puts "foofoo: #{args}"}

end

Foo.new.foo('yadayada')
