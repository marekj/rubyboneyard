# take from examples
#C:\ruby\lib\ruby\gems\1.8\gems\thin-1.2.4-x86-mswin32\example\adapter.rb

class SimpleAdapter

  def call(env) #object that responds to call and takes env as argument, right? 
    body = ["hello!"]
    [
      200,
      { 'Content-Type' => 'text/plain' },
      body
    ]
  end
end


# learn this.
Thin::Server.start('0.0.0.0', 3000) do
  use Rack::CommonLogger
  map '/test' do
    run SimpleAdapter.new
  end
  map '/files' do
    run Rack::File.new('.')
  end
end

# You could also start the server like this:
#
#   app = Rack::URLMap.new('/test'  => SimpleAdapter.new,
#                          '/files' => Rack::File.new('.'))
#   Thin::Server.start('0.0.0.0', 3000, app)
