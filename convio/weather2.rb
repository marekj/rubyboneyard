#read file as lines elements
file = File.join(File.dirname(__FILE__), "weather.dat")
lines = []
File.foreach(file) {|e| lines << e}

# this feels procedural => days = lines[8..37]
# let's find the rows that begin with day number instead
days = lines.map {|e| e.strip}.select {|e| e.match(/^[1-3]/)}

#and grab first 3 columns
days_temps = days.map {|e| e.split(" ")[0..2]}

#calculate spreads for each day
days_temps_spreads = days_temps.map {|e| e.push(e[1].to_i - e[2].to_i)}

# get lowest data
day, high, low, spread = days_temps_spreads.min {|a,b| a.last <=> b.last}
puts "Day #{day} had the lowest temperature spread of #{spread}, with high of #{high} and low of #{low}"

# => Day 14 had the lowest temperature spread of 2, with high of 61 and low of 59

