require 'watir'
require 'pp'

module Watir
  module Container

    def spyme
      puts "----------------begin spy ----------------"
      puts "self is: #{self.class}"
      puts self
      puts "page_container is: #{@page_container.class}"
      puts @page_container
      puts "container is: #{@container.class}"
      puts @container
      puts "----------------end spy ----------------"
      #puts "instance variables are"
      #puts self.instance_variables
    end

    def my_form(how, what)
      puts "inside form:"
      spyme
      temp = Form.new(self, how, what)
      puts "return form"
      puts temp.class
      puts temp.spyme
      temp
    end

    def my_text_field(how, what=nil)
      puts "inside text_field:"
      spyme
      temp = TextField.new(self, how, what)
      puts "return text_field"
      puts temp.class
      puts temp.spyme
      temp
    end

    def person()
      form(:name, 'person')
    end

    def face_last()
      text_field(:name, 'last_nm')
    end

    def self.face1 facename
      module_eval do
        define_method facename do
          text_field(:name, 'last_nm')
        end
      end
    end
    face1(:face_last1)

    def self.face2(facename, &block)
      module_eval do
        define_method(facename, &block)
      end
    end
    face2(:face_last2) {text_field(:name, 'last_nm')}

    def self.face3(facename, *args, &block)
      module_eval do
        define_method(facename, *args, &block)
      end
    end
    #face3(:face_last3) {text_field(:name, "last_nm")}
    face3(:face_last3)  { |*args| text_field(:name, "last_#{args}")}
    face3(:face_last3b) { |args|  text_field(:name, "last_#{args}")}


  end
end


ie = Watir::IE.attach :url, /person/

#ie.tf(:name, 'last_nm')
#ie.formo(:id, 'person')
#ie.spyme

#ie.my_form(:id, 'person').my_text_field(:name, 'last_nm')

#pp ie.person.last.value
#pp ie.person.text
#pp ie.face_last.value
#pp ie.face_last1.value
#pp ie.face_last2.value
#pp ie.face_last3("nm").value
#pp ie.face_last3b("nm").value
#pp tf

module PageObjects

  module ClassMethods
    def face4(facename, *args, &block)
      module_eval do
        define_method(facename, *args, &block)
      end
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end
end

module LastName
  include PageObjects
  face4(:face_last4) { text_field(:name, 'last_nm')}
end
puts LastName.instance_methods.sort.inspect

Watir::Element.send :include, LastName #pump the new methods into container
Watir::IE.send :include, LastName #pump the new methods into container
#Watir::Container.send :include, LastName #pump the new methods into container
#Watir::PageContainer.send :include, LastName #pump the new methods into container
#Watir::IE.send :include, Watir::Container # pump the container into class if needed. I don't understand it

puts Watir::Container.instance_methods.sort.select{|m| m.match(/^face/)}.inspect
puts Watir::Element.instance_methods.sort.select{|m| m.match(/^face/)}.inspect
puts Watir::IE.instance_methods.sort.select{|m| m.match(/^face/)}.inspect

ie2 = Watir::IE.attach :url, /person/
puts ie2.methods.sort.select{|m| m.match(/^face/)}.inspect
puts ie2.form(:name, 'person').methods.sort.select{|m| m.match(/^face/)}.inspect
puts ie.face_last4.value
puts ie.form(:name, 'person').face_last4.value
#puts Watir::IE.instance_methods.sort.select{|m| m.match(/^las/)}.inspect

