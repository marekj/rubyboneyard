require 'watir' # needs html/person.html file
require File.dirname(__FILE__) + "/object_instance_exec"
require 'pp'

module Page

  def browser
    @browser ||= Watir::IE.attach :url, /person\.html$/
  end
  
  # returns the page root starting with html
  # it is the same as browser however if there are frames you can set the page to a frame to be receiver of actions
  # page { browser.frame(:name, 'Name'}
  #
  # if you load the page and the frames are no longer there then you need to reset the page back to browser
  # page { browser }
  # @page_container and @container
  def page
    @container = browser
    self #chain
  end

  def set *args
    # for text_field you can set :random data
    # for radio select radom or default
    @container.set *args
  end

  #delegate to container becuase the mehtod sets container but returns self
  def selected
    @container.selected
  end

  #  def text
  #    @container.text
  #  end

  def value
    @container.value
  end

  # posssible way a facename can be defined as a body to be instance_evaled by the containing element.
  # then what it returns in turns sets the container for next chain method
  def panel
    @container = container.instance_eval do
      div(:id, "personPanel")
    end
    self
  end

  def last
    @container = container.instance_eval do
      text_field(:name,'last_nm')
    end
    self #return receiver
  end

  def config(&block)
    yield container
  end

  module ClassMethods
    def face(facename, *args, &block)
      module_eval do
        define_method(facename) do |*args|
          @container = @container.instance_exec(*args, &block)
          self #return receiver
        end
      end
    end
  end
  # if set or value or text methods are not defined it needs to have 
  def method_missing met, *args
    if @container.respond_to? met
      @container.send met, *args
    else
      raise "method unknown"
    end
  end

end

class TestScenario #self for keeping state

  include Page #adapter mechanism for shortcuts to elements and behaviour
  extend Page::ClassMethods

  face(:lasta) { text_field(:name,'last_nm') }
  face(:last2) { text_field(:name,'last_nm') }
  face(:lasta_extra) {|extra| text_field(:name,"last_#{extra}")}
  face(:panela) { div(:id, "personPanel") }

  def initialize
    # shift the page to frame else by defult it's a browser
    #page { browser }
    #pp page.lasta.value
    #pp self.inspect
    #pp lasta.value
    # pp lasta_extra("nm").value
    pp page.lasta.value
    pp page.panela.lasta.value #chaining
    pp page.lasta.value #resets to @page_container
    #pp browser.panel.last.value
    #pp browser.panela.last.value
    #    pp browser.last.value
    #    pp browser.title
    #    pp browser.panel.text_fields[3].exists?
    #
  end
end

uc = TestScenario.new
