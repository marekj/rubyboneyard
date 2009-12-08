use Rack::ContentLength

app = lambda do |env|
  # puts env.inspect # this will output in the stdout
  body = "<pre>"
  env.each do |k, v|
    body << "#{k} => #{v}\n"
  end
  body << "</pre>"

  # let's examine env
  [200, { 'Content-Type' => 'text/html' }, body]
end

run app #This run method comes from where???

=begin

SERVER_NAME => localhost
async.callback => #
rack.url_scheme => http
HTTP_ACCEPT_ENCODING => gzip,deflate
HTTP_USER_AGENT => Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5 (.NET CLR 3.5.30729)
PATH_INFO => /
rack.run_once => false
rack.input => #
SCRIPT_NAME =>
SERVER_PROTOCOL => HTTP/1.1
HTTP_ACCEPT_LANGUAGE => en-us,en;q=0.5
HTTP_HOST => localhost:3000
rack.errors => #
REMOTE_ADDR => 127.0.0.1
HTTP_KEEP_ALIVE => 300
REQUEST_PATH => /
SERVER_SOFTWARE => thin 1.2.4 codename Flaming Astroboy
HTTP_ACCEPT_CHARSET => UTF-8,*
HTTP_VERSION => HTTP/1.1
rack.multithread => false
rack.version => 10
async.close => #
REQUEST_URI => /
rack.multiprocess => false
SERVER_PORT => 3000
QUERY_STRING =>
GATEWAY_INTERFACE => CGI/1.2
HTTP_ACCEPT => text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
HTTP_CONNECTION => keep-alive
REQUEST_METHOD => GET

=end