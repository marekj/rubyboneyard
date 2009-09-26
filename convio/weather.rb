#First pass. work in irb
#read file as lines elements
file = File.join(File.dirname(__FILE__), "weather.dat")
lines = []
File.foreach(file) {|e| lines << e}

#grab records for days and temps
days = lines[8..37]
days_temps = days.map {|e| e.split(" ")[0..2]}

# calculate spreads for each day
days_spreads = []
days_temps.each {|e| days_spreads << [e[0], e[1].to_i - e[2].to_i]}

# get lowest
lowest = days_spreads.min {|a,b| a[1]<=> b[1]}
puts "Day #{lowest[0]} had the lowest temperature spread of #{lowest[1]}"

# =>  Day 14 had the lowest temperature spread of 2
