require 'sinatra'

get '/' do
  haml :index
end
# THIS DOES NOT WORK>
use_in_file_templates!

__END__

@@ layout
X
= yield
X

@@ index
%div.title Hello world!!!!!