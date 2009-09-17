require 'watir'
require File.dirname(__FILE__) + "/object_instance_exec"
require 'pp'

module Watir
  class Element
    # returns array of arrays where each element is a [name, value] as long as value is other than null or blank
    # example: <
    def attributes
      attrs = {}
      self.document.attributes.each do |atr|
        next if (atr.value == 'null') || (atr.value == '')
        attrs[atr.name] = atr.value
      end
      return attrs
    end
  end
end

module Page

  def browser
    @browser ||= Watir::IE.attach :url, /person\.html$/
  end

  module ClassMethods
    # can I do it without send or module_eval?
    def face1(facename, *args, &block)
      define_method(facename) do |*args|
        browser.instance_exec(*args, &block)
      end
    end


    def face1b(facename, *args, &block)
      define_method(facename) do |*args|
        #browser.instance_exec(*args, &block)
        wobj = browser.instance_exec(*args, &block)
        puts wobj.class
        puts wobj.attributes.inspect
        return wobj
      end

    end

    def face1c(facename, *args, &block)
      module_eval do #module_eval is not needed but does it hurt it?
        define_method(facename) do |*args|
          browser.instance_exec(*args, &block)
        end
      end
    end



    def face2(facename, *args, &block)
      module_eval do
        define_method(facename, *args, &block)
      end
    end

    def face3(facename, *args, &block)
      __send__ :define_method, facename, *args, &block
    end

  end
end

class Face1 #self for keeping state
  include Page #adapter mechanism for shortcuts to elements and behaviour
  extend Page::ClassMethods
  # using exec
  face1(:last_name) { text_field(:name,'last_nm') }
  face1(:last_extra) {|extra| text_field(:name,"last_#{extra}")}
  face1(:panel) { div(:id, "personPanel") }

  def initialize
    #pp last_name.value
    #pp panel.text_fields.length
    #pp last_extra('nm').value

    # this should be possible
    last_name do
      puts "Passing block to method"
      puts @page_container.class #eval
    end

    puts "EXPERIMENT"
    bla = lambda { text_field(:name,'last_nm') }
    browser.instance_exec do
      bla.call
    end

  end
end



class Face1b #self for keeping state

  def self.method_added mname
    puts "adding method: #{mname}"
  end

  define_method(:bla) do
    puts "hello bla"
  end

  __send__ :define_method, :bla2 do
    puts "bla2"
  end
  
  include Page #adapter mechanism for shortcuts to elements and behaviour
  extend Page::ClassMethods

  # using exec
  face1b(:last_name) { text_field(:name,'last_nm') }
  face1b(:last_extra) {|extra| text_field(:name,"last_#{extra}")}
  face1b(:panel) { div(:id, "personPanel") }



  def initialize
    pp last_name.value
    pp panel.text_fields.length
    pp last_extra('nm').value

    # this should be possible
    last_name do
      puts "Passing block to method"
      puts @page_container.class
    end

  end
end


class Face1c

  include Page #adapter mechanism for shortcuts to elements and behaviour
  extend Page::ClassMethods

  # using exec
  face1c(:last_name) { text_field(:name,'last_nm') }
  face1c(:last_extra) {|extra| text_field(:name,"last_#{extra}")}
  face1c(:panel) { div(:id, "personPanel") }

  def initialize
    pp last_name.value
    pp panel.text_fields.length
    pp last_extra('nm').value

    # this should be possible
    last_name do
      puts "Passing block to method"
      puts @page_container.class
    end

  end
end

class Face2 #self for keeping state
  
  include Page #adapter mechanism for shortcuts to elements and behaviour
  extend Page::ClassMethods
  
  face2(:last_name) { browser.text_field(:name,'last_nm') }
  face2(:last_extra) {|extra| browser.text_field(:name,"last_#{extra}")}
  face2(:panel) { browser.div(:id, "personPanel") }

  def initialize
    #pp last_name.value
    #pp panel.text_fields.length
    #pp last_extra('nm').value

    # this should be possible
    last_name do
      puts "Passing block to method"
      puts @page_container.class
    end

  end
end


class Face3 #self for keeping state

  include Page #adapter mechanism for shortcuts to elements and behaviour
  extend Page::ClassMethods

  # define creator inside the class.
  # but it only returns what was in a block
  def self.face3class(facename, *args, &block)
    send :define_method, facename, *args, &block
  end

  face3(:last_name) do 
    browser.text_field(:name,'last_nm')
  end
  face3(:last_extra) {|extra| browser.text_field(:name,"last_#{extra}")}
  face3class(:last_extra_class) {|extra| browser.text_field(:name,"last_#{extra}")}

  face3(:panel) { browser.div(:id, "personPanel") }

  def initialize
    pp last_name.value
    pp panel.text_fields.length
    pp last_extra('nm').value
    pp last_extra_class('nm').value

    # this should be possible? 
    last_name do
      puts "Passing block to method"
      puts @page_container.class
    end

  end
end

Face1.new
#Face1b.new
#Face1c.new
#Face2.new
#Face3.new
