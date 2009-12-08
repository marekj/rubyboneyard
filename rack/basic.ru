use Rack::ContentLength

# below here Not sure if response body just string is correct (well, responds to each, no?)
app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, 'Hello World'] }

# From thin config.ru example:
# Response body has to respond to each and yield strings
# See Rack specs for more info: http://rack.rubyforge.org/doc/files/SPEC.html
#
# simplest version
# app = lambda { |env| [200, {}, ['hi!']] }
#

run app


=begin
regular ruby code in *.ru files
http://vision-media.ca/resources/ruby/ruby-rack-middleware-tutorial

run this
$ rackup basic.ru -p 3000

by default this will use webrick it seems (even if I have thin installed)
hitting the server will always return the body 'Hello World'

http://localhost:3000/
http://localhost:3000/hello/empire/

# log
127.0.0.1 - - [18/Nov/2009 19:56:29] "GET /hello/empire HTTP/1.1" 200 11 0.0000
127.0.0.1 - - [18/Nov/2009 19:56:33] "GET / HTTP/1.1" 200 11 0.0000


run this with thin server
$ rackup basic.ru -p 3000 -s thin
or

$ thin start -R basic.ru #?



about the basic.ru
the object has to respond to call method so you can have a proc right?
so this code will work

app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, 'Hello World'] }
run app


this part

[200, { 'Content-Type' => 'text/html' }, 'Hello World']

is

status, header, body

in that order

from Rack spec doc
A Rack app is an Ruby object (not a class) that responds to call
takes exactly one argument (env)
And returns an Array of exactly three values: status, headers, body.
stauts = 200
headers = {} hash
body = responds to each so [] or "string?"
=end