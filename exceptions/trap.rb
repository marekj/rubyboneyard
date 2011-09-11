require 'pp'

#exit handlers       hooks

#>> Signal.list
#=> {"SEGV"=>11, "KILL"=>9, "TERM"=>15, "INT"=>2, "FPE"=>8, "ABRT"=>22, "ILL"=>4, "EXIT"=>0}

trap('EXIT') do
  reason = $! ? 'because of exception' : 'naturally'
  pp "in a trap = #{reason}"
  #$! = nil #destroy and others will not see it
end

END {
  reason = $! ? 'because of exception' : 'naturally'
  pp "in an END = #{reason}"
}

at_exit do
  reason = $! ? 'because of exception' : 'naturally'
  pp $!
  pp "at exit = #{reason}"

end

abort 'abort'

#fail 'last exception' #causes $!

# trap, END, at_exit
