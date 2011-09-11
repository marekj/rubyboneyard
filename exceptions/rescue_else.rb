require 'pp'

begin

rescue
  # something above went bang! and we rescue here
else
  # nothing went bang! this will run when NO exception has occured between 'begin and rescu'
ensure
  # went bang! or not I don't care, run this code here
end


begin
  pp 'success'
rescue
  pp 'no need to rescue me'
else
  hooray  # this will fail of course and will not be rescued unless caller rescues it
ensure
  pp 'ensure'
end
