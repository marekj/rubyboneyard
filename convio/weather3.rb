#read file as lines elements
lines = []
File.foreach(File.join(File.dirname(__FILE__), "weather.dat")) {|e| lines << e}

# clever evil solution
day, high, low, spread = lines.
  map { |e| e.strip }.
  select { |e| e.match(/^[1-3]/) }.
  map { |e| e.split(" ")[0..2] }.
  map { |e| e.push(e[1].to_i - e[2].to_i) }.
  min { |a,b| a.last <=> b.last }

puts "Day #{day} had the lowest temperature spread of #{spread}, with high of #{high} and low of #{low}"
# => Day 14 had the lowest temperature spread of 2, with high of 61 and low of 59

