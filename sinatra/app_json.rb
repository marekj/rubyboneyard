require 'sinatra'
require 'json'


get "/stocks.json" do
  content_type :json
  {:ticker => 'ABC', :price => '45567.98'}.to_json
end


get "/hello/:bla" do
  content_type :json
  {:param => params[:bla]}.to_json
end


=begin

http://groups.google.com/group/ruby-craftsmanship

github.com/madriska/algotraitor
github.com/madriska/algotraitor-client

rest-client
json
=end