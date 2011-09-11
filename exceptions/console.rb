require 'pp'

$stderr.puts "hello empire"

$stdout.puts "out with it"
$stderr << 'hello'
$stderr.flush

# buffered so it may not be in order

# use warn instead
warn 'bad bad things'

# use $DEBUG flag -d



# bulkhead or barricades
begin
  call to some external service that will fail
rescue Exception  =>  e
  pp e # and log it don't let external stuff destroy your app
end


#Circuit Breaker pattern


#exit call realy calls raise SystemExist exception
exit


abort "some message" #same as exit 1

#finally
exit 1 #just kill the process
