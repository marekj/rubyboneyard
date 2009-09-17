require 'spec'


class Srun
  def self.before
    'Hello Before'
  end
end

Spec::Runner.configure do |c|
  c.before Srun.before
end

  
describe 'Someting'  do
  it 'is green' do
    'gree'.should == 'green'
  end
end



