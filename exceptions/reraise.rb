require 'pp'


#begin
#  fail 'yowza'
#rescue
#  pp 'resuce me'
#  raise # raises original failure
#end


#begin
#  fail 'yowiwiwi'
#rescue => e
#  pp 'rescue me'
#  raise e    # also the original
#end

#begin
#  fail 'yowyow'
#rescue
#  raise $! # same as above
#end

#begin
#  fail 'wow'
#rescue
#  fail 'bla' # this eats the first exception and we'll never know aobut it
#end


# use nested exceptions instead or don't do it

## this may be an idiotic way of handling the parent, child thing
#begin
#  pp 'begin parent'
#  #fail 'parent exception' # this goes straight to rescue clause
#  begin
#    fail 'child exception'
#  rescue
#    pp 'catching child exception and raising to parent'
#    raise # this goes to parent rescue clause
#  end
#
#rescue
#  pp 'parent exception or child exception'
#  raise
#end



require 'nestegg'

class MyError < StandardError
  include Nestegg::NestingException
end


begin
  require 'myawesomegem'
rescue LoadError
  fail MyError, 'can not initialize meself'
end
