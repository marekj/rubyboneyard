
class UseCase
  attr_accessor :scenario
  
  def initialize
    @scenario = [:do_this, :do_that]
  end
  
  def do_this
    'thisa'.should == 'thisa'
  end
  
  def do_that
    'that'.should == 'that'
  end
  
  def do_some_other
    'some'.should == 'some'
  end
  
  
  def run_as_rspec
    uc = self
    describe "#{uc.class.to_s}" do
      context "context" do
        uc.scenario.each do |sc|
          it "#{sc}" do
            uc.send sc
          end
        end
      end
    end
    
  end
  
end
