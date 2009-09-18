count = 0
while $<.gets
  count += 1 unless $_ =~ /^\s*($|#)/   # Any number of spaces followed by EOL or #
end
puts "#{count} lines of real code"
