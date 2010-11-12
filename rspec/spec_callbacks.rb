require 'spec/autorun'


class Srun
  def self.before
    puts 'Hello Before'
  end
end


Spec::Runner.configure do |c|
  c.append_before { Srun.before } # supply method body as block argument
end

describe 'Someting' do
  it 'is green' do
    'green'.should == 'green'
  end
end



