require 'pp'

# rescue modifier as strategy for what's returned if exception occurs. wise?
f = open("nonesuch.txt") rescue $!       # strategy for file or exception
pp f
f = open("nonesuch.txt") rescue nil      # strategy for file or nil
pp f



def ignore_exceptions(*exceptions)
  yield
rescue *exceptions => e
  puts "IGNORED: ’#{e}’"
end

ignore_exceptions LoadError, IOError, SystemCallError do
  open("NONEXISTENT_FILE")
end

