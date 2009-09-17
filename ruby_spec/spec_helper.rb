require File.join(File.dirname(__FILE__), %w[.. lib i_heart_ruby])
require 'spec'
require 'pp'

class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end
