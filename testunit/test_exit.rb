require 'test/unit'
require 'watir/testcase'
Test::Unit.run=true #do not autorun tests. run them explicitly with TestRunner

class Foo < Watir::TestCase
  require 'spec/expectations'

  # use Rspec Matcher
  include Spec::Matchers

  def teardown
    #    puts self.inspect
    #    puts self.instance_variables
    #    puts "----------"
    #    puts @_result.inspect
    #    puts @test_passed.inspect
    #    unless @test_passed
    #      test_finish
    #      exit
    #    end
  end


  def test_1
#    verify_equal 1, 1
#    verify_equal 2, 3
#    verify_equal 3, 4
    1.should == 1
  end

  def test_2
    2.should == 3
  end

  def test_3
    3.should == 3
  end

end

require 'test/unit/ui/console/testrunner'
class ExitOnErrorRunner < Test::Unit::UI::Console::TestRunner
  def add_fault(fault)
    @faults << fault
    nl
    output("%3d) %s" % [@faults.length, fault.long_display])
    output("---")
    @already_outputted = true
  end

  def finished(elapsed_time)
    nl
    output("Finished in #{elapsed_time} seconds.")
    nl
    output(@result)
  end
end

class Test::Unit::TestResult
  # if errors array is not empty we have errors present
  def has_errors?
   !@errors.empty?
  end
end

class Test::Unit::TestSuite
  # TestSuite.
  def run(result, &progress_block)
    yield(STARTED, name)
    @tests.each do |test|
      test.run(result, &progress_block)
      break if result.has_errors? #stop running tests on failure
    end
    yield(FINISHED, name)
  end
end

#ExitOnErrorRunner.run Foo, 3
Test::Unit::UI::Console::TestRunner.run Foo



