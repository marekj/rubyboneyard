require 'spec'

module Mastermind
  class Game
    def initialize(messenger)
      @messenger = messenger
    end
    def start(code)
      @messenger.puts "Welcome To Mastermind"
      @messenger.puts "Enter guess:"
    end
  end
end


module Mastermind
  describe Game do
    context "starting up" do
      before :each do
        @messenger = mock("messenger").as_null_object
        @game = Game.new(@messenger)
      end
      it 'should send a welcome message (passing the code to start)' do
        @messenger.should_receive(:puts).with("Welcome To Mastermind")
        @game.start %w[r g y c]
      end
      
      it "should prompt for the first guess" do
        @messenger.should_receive(:puts).with("Enter guess:" )
        @game.start %w[r g y c]
      end
    end
  end
end



=begin
describe => Spec::ExampleGroup
context =

=end