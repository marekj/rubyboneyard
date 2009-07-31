require 'watir'
require 'pp'


module Page

  def browser
    @browser ||= Watir::IE.attach :url, /person\.html$/
  end

  # returns the page root starting with html
  # it is the same as browser however if there are frames
  # you can set the page to a frame to be receiver of actions
  # if you load the page and the frames are no longer there
  # then you need to reset the page back to browser
  def page
    @page ||=browser
  end

  # for example set_page browser.frame(:name, 'name')
  def set_page container
    @page = container
  end

  module ClassMethods
    def face(facename, *args, &block)
      module_eval do
        define_method(facename) do |*args|
          page.instance_exec(*args, &block) # page is always the receiver
        end
      end
    end
  end
end

class TestScenario #self for keeping state

  include Page #adapter mechanism for shortcuts to elements and behaviour
  extend Page::ClassMethods

  face(:last) { text_field(:name,'last_nm') }
  face(:last_extra) {|extra| text_field(:name,"last_#{extra}")}
  face(:panel) { div(:id, "personPanel") }

  def initialize
    #pp self.inspect
    pp last.value
    pp panel.text_fields.length
    pp last_extra('nm').value
  end
end

TestScenario.new
