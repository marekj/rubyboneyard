require 'spec/autorun'
Spec::Runner.configure do |config|
  # ?
end

$a = []
$a << "begin"
class UseCase
  attr_accessor :scenario, :bla
  
  def initialize
    @scenario = [:do_this, :do_that]
    @bla = "bla"
  end
  
  def do_this
    $a << "this for #{self.inspect}"
    puts $a.inspect
    'this'.should == 'this'
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

  def self.run_as_rspec(name='usecase_as_rspec_examples')
    uc = self.new
    yield uc if block_given?
    #puts "#{uc.inspect}"
    example_group_name = "#{uc.class.to_s} - #{name}"
    example_group_class = describe example_group_name do
      #$a << self
      subject {uc}
      uc.scenario.each do |sc|
        it "#{sc}" do
          uc.send sc
        end
      end
    end
    puts example_group_class.inspect
    #Spec::Runner.options.add_example_group example_group_class #incject the example group to run
    #puts Spec::Runner.options.inspect
    #Spec::Runner.run #run all example groups that have not been run
    #Spec::Runner.options.remove_example_group example_group_class #incject the example group to run
  end

end

UseCase.run_as_rspec('happy')

UseCase.run_as_rspec('foo') do |uc|
  uc.scenario = [:do_that]
  uc.bla = 'foo'
end
$a << "done1"
UseCase.run_as_rspec('bar') do |uc|
  uc.scenario = [:do_this]
  uc.bla = 'bar'
end

$a << 'done2'
UseCase.run_as_rspec('baz') do |uc|
  uc.scenario = [:do_that]
  uc.bla = "baz"
end

$a << 'exit here'
puts $a.inspect # => 'done' will be the only item becasue the rspec exampes will run at_exit

