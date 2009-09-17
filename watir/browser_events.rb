# Watirloo::Browser::HtmlSaver
# Watirloo::Browser::EventsPublisher
# Watirloo::Browser::SessionSaver
# Watirloo::Browser::Manager

# Watirloo addition: let Watir watch your browser navigation events
# and save your html as you do exploratory testing
# ISSUE: :response somehow blocks the HtmlSaver in some of my pages. don't know why
require 'observer'

# InternetExplorer Object DWebBrowserEvents2 is an Interface for Events.
# We can hook into the events and intercept the events we care to catch.
# Every time an event we care to watch for occurs the Publisher notifies observers.
# Extra: you can also build a publisher that listenes to 'HTMLDocumentEvents2' of ie.ie.document object
# and notify listeners to onclick events if you need to
# @events_to_publish = %w[BeforeNavigate2 DocumentComplete NavigateError NewWindow3]
class BrowserEventsPublisher
  include Observable
  
  def initialize( ie )
    puts "BrowserEventsPublisher started for #{ie.hwnd}"
    @events_to_publish = %w[BeforeNavigate2 DocumentComplete NavigateError NewWindow3 OnQuit]
    @ie, @ie_object = ie, ie.ie
    @event_sink = WIN32OLE_EVENT.new( @ie_object, 'DWebBrowserEvents2' )
  end
  
  def browser
    return @ie
  end

  def run
    return unless browser.exists?
    @alive = true
    @events_to_publish.each do |event_name|
      @event_sink.on_event(event_name) do |*args|
        changed
        notify_observers( event_name )
        @alive = false if event_name == "OnQuit" 
      end
    end
    puts "start publishing"
    #loop { WIN32OLE_EVENT.message_loop }
    begin 
      WIN32OLE_EVENT.message_loop
    end while @alive
    puts "stopped liestening. browser no longer available for listening"  
  end
end

# Generic Observer of BrowserEventsPublisher.
# implements update method of an observer to be notified by publisher of events
class BrowserEventsListener
  
  def initialize( events_publisher )
    puts "BrowserEventsListener started for #{events_publisher.browser.hwnd}"
    events_publisher.add_observer self
    @saver = HtmlSaver.new events_publisher.browser
  end

  def update event_name
    puts event_name
    #@saver.save(:request) if event_name == "BeforeNavigate2" #save the html page as is right before submit
    #@saver.save(:response) if event_name == "DocumentComplete"
  end
  
end

# get html from the page.
# process html with additional test information 
# and save html for audit
# start the object and and refernce the browser you will work with.
# you can reuse this object for as longs as the browser exists
class HtmlSaver
  
  def initialize( browser )
    puts "HtmlSaver started for #{browser.hwnd}"
    @browser = browser
  end

  
  def save
    return false unless @browser.exists?
    @timestamp = Time.now.strftime('%m%d_%H%M_%S')
    html = prepare_html
    File.open("#{@timestamp}.html", 'w') {|f| f.write(html)}
  end
  
  
  def prepare_html
    html, url = @browser.html, @browser.url

    require 'hpricot'
    hdoc = Hpricot(html)
    
    hdoc.search("head").prepend <<-eos
    <meta keyword='timestamp' content='#{@timestamp}'>
    <meta keyword='saved_url' content='#{url}'>
    <meta keyword='event' content='#{@event}'>
    <base href='#{File.dirname url}/' />
    eos
    
    hdoc.search("body").prepend <<-eos
    
    <div id='testnote' style='position:absolute;left:0px;top:0px;overflow:auto;border:2px solid green;background-color:#ffc;font-size:12px' title='
    event: #{@event}
    timestamp: #{@timestamp}
    saved_url: 
      #{url}
    '>TestNote: #{@event}</div>
    eos

    hdoc.to_html #return repackaged html with testnotes
    
  end
  
end


if $0 == __FILE__
  require 'watir'
  ie = Watir::IE.attach( :url, // )
  events_publisher = BrowserEventsPublisher.new( ie )
  BrowserEventsListener.new events_publisher
  events_publisher.run
  
end