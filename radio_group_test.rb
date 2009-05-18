require File.dirname(__FILE__) + '/../lib/watirloo'

class RadioGroup1 < Page

  def food
    RadioGroup.new @b, 'food', 'Hotdog' => 'hotdog', 'Tofu' => 'tofu' 
  end
end

class RadioGroup
  def initialize browser, name, mapping
    @browser = browser
    @name = name
    @mapping = mapping
  end
  def set human_value
    @browser.radio(:name, @name, @mapping[human_value]).set
  end
  def value
    radio_group = @browser.radios.select {|r| r.name == @name}
    puts radio_group
    radio_set = radio_group.detect {|r| r.isSet?}
    value = radio_set.ole_object.invoke('value')
    @mapping.invert[value]
  end
end

require 'test/spec'

#describe RadioGroup do
#  
#  setup do
#    @page = RadioGroup1.new
#    @page.goto File.dirname(__FILE__) + '/html/radio_group1.html'
#  end
#  
#  it 'should report its value' do
#    @page.food.value.should == 'Hotdog'
#  end
#
#  it 'should be able to be set' do
#    @page.food.set 'Tofu'
#    @page.food.value.should == 'Tofu'
#  end  
#  
#  it 'should fail when given a value not in the mapping' do
#    lambda {@page.food.set 'Not on Menu'}.should raise ArgumentError
#  end
#  
#end