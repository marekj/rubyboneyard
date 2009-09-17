#require 'rubygems'
require 'sinatra'

get '/' do
  #'Hello world!'

    # Get the string representation
    cookie = request.cookies["thing"]
 
    # Set a default
    cookie ||= 0
 
    # Convert to an integer 
    cookie = cookie.to_i
 
    # Do something with the value
    cookie += 1
 
    # Reset the cookie
    set_cookie("thing", cookie)
 
    # Render something
    "Thing is now: #{cookie}"
end