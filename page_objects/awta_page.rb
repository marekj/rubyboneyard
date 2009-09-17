#metaid by _why
class Object
  # The hidden singleton lurks behind everyone
  def metaclass
    class << self
      self 
    end 
  end
  
  def meta_eval(&blk)
    metaclass.instance_eval(&blk)
  end
  
  # Adds methods to a metaclass
  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end

  # Defines an instance method within a class
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end
end

# instance_exec comes with >1.8.7 thankfully
if VERSION <= '1.8.6'
  class Object
    module InstanceExecHelper; end
    include InstanceExecHelper
    # instance_exec method evaluates a block of code relative to the specified object, with parameters whom come from outside the object.
    def instance_exec(*args, &block)
      begin
        old_critical, Thread.critical = Thread.critical, true
        n = 0
        n += 1 while respond_to?(mname="__instance_exec#{n}")
        InstanceExecHelper.module_eval{ define_method(mname, &block) }
      ensure
        Thread.critical = old_critical
      end
      begin
        ret = send(mname, *args)
      ensure
        InstanceExecHelper.module_eval{ remove_method(mname) } rescue nil
      end
      ret
    end
  end
end


# Hugh's stuff he shared
class PageRasta
  class << self
    attr_accessor :browser
   
    def keyword(method_name, *args, &block) 
      meta_def method_name do             # I included the Object class from Why's Poignant Guide
        instance_exec(*args, &block)      # I'm using an older version of ruby so have some code to handle this call
      end
    end
   
    def browser
      @browser ||= Watir::IE.new
    end
  end
end


# superior implementation based on simplicity
class PageByClassEval
  attr_accessor :browser
  #Page Eigenclass
  class << self
    
    # setup face here as class_eval
    def interface(field, definition)
      watirmethod, how, what, value = *definition
      extra = value ? ", '#{value}'" : nil
      class_eval "def #{field}
                    browser.#{watirmethod}(:#{how}, '#{what}'#{extra}) 
                  end"
    end
  end
end

# crappy polish immmigrant contraption
# this is original watirloo face creation with method missing.
# it also uses interfaces hash to keep track data.
# the define_method is better becuase it's a real method 
# and not a fake method generated on the fly
class PageByMethodMissing
  attr_accessor :browser, :interfaces
  class << self
    def interfaces
      @interfaces ||= {}
    end
    def interface(definition)
      self.interfaces.update definition
    end
    def inherited(subpage)
      subpage.interfaces.update self.interfaces
    end
  end
  def create_interfaces
    @interfaces = self.class.interfaces.dup # do not pass reference, only values that's why you dup
  end
  def initialize
    create_interfaces
  end
  def method_missing method
    watirmethod, *args = self.interfaces[method]
    return @browser.send(watirmethod, *args)
  end
end

require 'watir'
# github.com/marekj/watirloo/test/html/person.html
@ie = Watir::IE.attach :url, //

require 'benchmark'
result = Benchmark.bmbm do |test|
 
  test.report('subclass with class eval') do
    class TopPage < PageByClassEval
      interface :first, [:text_field, :name, 'first_nm']
    end
    1000.times do
      page = TopPage.new
      page.browser = @ie
      page.respond_to? :first
      page.first.value
    end
  end
  
  test.report('subclass with method missing') do
    class TopPage2 < PageByMethodMissing
      interface :first => [:text_field, :name, 'first_nm']
    end
    1000.times do
      page = TopPage2.new
      page.browser = @ie
      page.respond_to? :first
      page.first.value
    end
  end
end


puts total = result.inject(0.0) { |mem, bm| mem + bm.real }
puts "total : " + total.to_s
puts "average: " + (total/result.size.to_f).to_s
  
#  it 'creates methods for interfaces' do
#    @page.respond_to?(:last).should.be true
#    @page.respond_to?(:pets).should.be true
#  end
#  
#  it 'responds to parents methods as well' do
#    @page.respond_to?(:first).should.be true
#  end
#  
#  it 'talks to the browser' do
#    @page.last.set 'This Is Way Too Easy'
#    @page.last.value.should == "This Is Way Too Easy"
#  end
#  
#  it 'talks to another element' do
#    @page.pets.set 'cat'
#    @page.pets.getSelectedItems.should == ['cat']
#  end
#  
#  it 'talks to the browser using parents methods' do
#    @page.first.set 'This Is Way Too Easy'
#    @page.first.value.should == "This Is Way Too Easy"
#  end
#
#end


#class SubPage < Page
#  define :horse do |v|
#    radio(:name, 'pets', v)
#  end
#  define :link do |text|
#    link(:text, text).click
#  end
#end
#class SubSubSubPage < SubSubPage
#  define :kwa => 'kwa'
#end
#page1  = SubPage.new
#page2 = SubSubPage.new
#puts page1.interfaces.keys.inspect
#
#puts SubSubPage.classfaces.keys.inspect
#page2.define :inst => 'inst'
#puts page2.interfaces.keys.inspect
#puts SubSubPage.classfaces.keys.inspect
#puts SubSubSubPage.classfaces.keys.inspect
#page1.define :page1 => 'page1'
#puts page1.interfaces.keys.inspect
#puts page2.interfaces.keys.inspect

#puts Page.interfaces.keys.inspect
#puts SubPage.interfaces.keys.inspect
#puts SidePage.interfaces.keys.inspect

