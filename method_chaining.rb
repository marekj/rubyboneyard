# dynamic method generation and method chaining silly example
class Speaker
  def self.words(words)
    words.each do |word|
      define_method(word) do
        puts word
        self #chain
      end
    end
  end
end


Speaker.words %w[hello blue monday]
Speaker.words %w[goodbye world]

speak = Speaker.new

speak.
    goodbye.
    blue.
    monday.
      hello.
      world

#add more vocabulary here
Speaker.words %w[watir library is the best in the]

speak.
     watir.
     library.
      is.
        the.best.in.the.world



# outputs this
#"goodbye"
#"blue"
#"monday"
#"hello"
#"world"
#"watir"
#"library"
#"is"
#"the"
#"best"
#"in"
#"the"
#"world"

