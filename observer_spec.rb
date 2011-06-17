require 'spec/autorun'

require 'observer'

# Observable object, publisher of events
class LoudMouthBroadcaster
  include Observable

  def speak event
    changed # => gatekeeper mechanism
    notify_observers event #=> only if changed?
  end

end

# observers that will register with observable
class GentleListener
  attr_reader :last_update

  def update event #=>  observer must respond to :udpate to be notified
    @last_update = event
    puts "#{self.class} : #{event}"
  end
end

class IgnoringListener
  attr_reader :last_update

  def update event
    @last_update = "ignoring #{event}"
    puts "#{self.class} : #{event}"
  end
end

describe "Obeservable pattern example" do
  specify "x" do
    publisher = LoudMouthBroadcaster.new
    listener1 = GentleListener.new
    listener2 = IgnoringListener.new
    publisher.add_observer listener1
    publisher.add_observer listener2
    publisher.speak 'wow wow wow'
    listener1.last_update.should == 'wow wow wow'
    listener2.last_update.should == 'ignoring wow wow wow'
  end
end

