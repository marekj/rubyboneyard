require 'activesupport'

require 'watir'
require 'watir/testcase'

require 'spec/expectations'
class Test::Unit::TestCase
  include Spec::Matchers
end

class UseCaseTestCase < Watir::TestCase

  def initialize(name)
    #super name
    @method_name = name
    @test_passed = true
  end

  def test_bla
    puts "bla"
  end
end


class UseCase

  attr_accessor :scenario, :bla

  def self.suite
    @suite_collection ||= []
  end

  def initialize(name='usecasename')
    @name = name
    @scenario = [:do_this, :do_that]
    @bla = "bla"
  end

  def do_this
    $a << "this for #{self.inspect}"
    puts $a.inspect
    'this'.should == 'that'
  end

  def do_that
    $a << "that for #{self.inspect}"
    puts $a.inspect
    'that'.should == 'that'
  end

  def do_some_other
    $a << 'some other'
    puts 'some other'
    'some'.should == 'somea'
  end

  def self.run_as_test(name='testunit_tests')

    uc = self.new(name)
    yield uc if block_given?
    #testcase_class_name = "#{uc.class} #{name}".parameterize.underscore.camelize
    uc.class_eval do # FIXME I give up.... don't know what I am doing here.
      
      puts self.inspect
      self.class.suite_collection = []
      uc.scenario.each do |task|
        define_method "test_#{task}" do
          task
        end
        self.class.suite_collection << "test_#{task}"
      end
    end

    require 'test/unit/ui/console/testrunner'
    Test::Unit::UI::Console::TestRunner.run uc
    #eval(testcase_class_name) #eval is needed and not constantize becuse constatn does not exist in context here and will not be found

  end

end
UseCase.run_as_test

#UseCase.run_as_test('get me to this place') do |uc|
#  uc.scenario = [:do_that]
#  uc.bla = 'foo'
#end
