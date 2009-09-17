require 'spec'
## 5 forms of making a class method definition (singleton)
#class Nobody
#  class << self
#    def who?
#      
#    end
#  end
#end
#class Nobody
#  def Nobody.who?
#    
#  end
#end
#
#class Nobody
#  def self.who?
#    
#  end
#end
#
#class Nobody
#  
#end
#def Nobody.who?
#  
#end

class Nobody
end

# singleton method on a class object
# gets inherited by subclasses
def Nobody.who?
  "I was #{ancestors[1]} but I am #{self} now"
end

describe Nobody do
  it 'added class method' do
    Nobody.who?.should == 'I was Object but I am Nobody now'
  end
end

class Legend < Nobody
end

describe Legend do
  it 'sublcass of Nobody inherits method' do
    Legend.who?.should == 'I was Nobody but I am Legend now'
  end
end


module Role
  def self.who?
    "Role? I was #{ancestors[1]} but I am #{self} now"
  end
end

describe Role do
  it 'Nobody extends Role' do
    Nobody.extend(Role)
    Nobody.who?.should == "I was Object but I am Nobody now"
  end
  
  it "Reopen Nobody and include Role" do
    class Nobody
      include Role
    end
    Nobody.who?.should == "I was Role but I am Nobody now"
  end
end


class Bla
  def talk
    puts 'bla talk'
  end
end

bla = Bla.new
# new method on object only
def bla.bla
  puts 'blabla'
end

bla.bla #this is defined on object only.
bla.talk #this is defined in class

# redef talk method of the object instantiated from class. 
# the talk method is only true for object, it does not reopen the class
def bla.talk
  puts 'Talk to super first'
  super()
  puts 'I can talk after return from super'
end
bla.talk


#blabla
#bla talk
#Talk to super first
#bla talk
#I can talk after return from super

class << bla #reopen singleton class for object bla
  def tell
    puts "I am gonna tell you in a minute"
    talk # call the method below and not previous becuase this is all insdie the signleton class definition block
  end
  
  def talk #clobber previous singleton method
    puts 'singleton form'
    super() #calls the class and not the last method redefined
    puts 'back from super to singleton'
  end
  p ancestors
end

bla.tell
bla.talk


