require 'watir'


# The manager 
# checks to see what browsers already exist on the dekstop.
# compares what is on the desktop to what is in the storage
# 
class BrowserManager
  
end



# manages references to browsers we care about to run tests agains.
# Saves references to window handles internall to yaml file so we can reuse the browser for tests by reattaching to it between tests.
# you put reference to a browser in storage. Next time you run a test you can restore the browser's reference instead fo staring a new one. 
class BrowserStorage
  @@storage = File.join(File.dirname(__FILE__), "browser_storage.yml")
  
  class << self
    
    # hash of {tag => IE.hwnd} to attach and reuse browsers
    # example: sessions = {:default=> 234567, :bla => 234234}
    def sessions
      @sessions ||= read_sessions
    end
    
    # returns IE reference to a browser with a given tag 
    def browser(tag='default')
      if tag == 'default'
        @browser ||= attach_browser #reuse default wihtout reattaching
      else
        attach_browser tag
      end
    end
    
    # add browser to storage for later reuse. by convention if you don't have any browsers it 
    # so you can later restore it and continue working with it.
    def add(tag='default', browser=Watir::IE.new_process)
      sessions[tag] = browser.hwnd
      save_sessions
      @browser = browser if tag=='default' #hold ref to default only. minimize reading yaml file
      return browser
    end
    
    # remove browser from storage and from further reusing
    def remove(tag='default')
      @browser = nil if tag == 'default'
      sessions.delete(tag) if sessions[tag]
      sessions.clear if tag == :all
      save_sessions
    end

    # clear Storage
    def clear
      @browser = nil
      sessions.clear
      save_sessions
    end
    
    private
    
    def read_sessions 
      if FileTest.exists?(@@storage)
        YAML::load_file(@@storage) 
      else
        {} #empty hash if stores not created yet
      end
    end
    
    def save_sessions
      File.open(@@storage,'w') {|f| YAML.dump(sessions, f)}
    end
    
    def attach_browser(tag='default')
      begin
        Watir::IE.attach(:hwnd, sessions[tag])
      rescue Watir::Exception::NoMatchingWindowFoundException
        return nil #just blow up like Watir would when trying to attach to browser that does not exist
      end
    end

  end
end

#
## Given there are no browser on the desktop run this test
#require 'spec'
#require 'spec/autorun'
#
#describe "TestSession1: BrowserSession when no browser exists on the destkop and session is empty" do
#  context "start with cleared sessions and add 2 browsers to storage" do
#    it 'force clear sessions and storage should start with empty hash' do
#      BrowserSession.clear
#      BrowserSession.sessions.should == {}
#    end
#    
#    it 'add a default browser to session starts browser, tags it default and stores it for later reuse' do
#      ie = BrowserSession.add
#      BrowserSession.sessions.keys.should == ['default']
#    end
#    
#    it 'reuse returns default browser stored in sessions' do
#      ie = BrowserSession.reuse
#      ie.should be_kind_of(Watir::IE)
#      ie.hwnd.should == BrowserSession.sessions['default']
#    end
#  
#    it 'add a second browser to session starts browser and store its ref in a storage for later reuse' do
#      BrowserSession.add 'second', Watir::IE.new_process
#      BrowserSession.sessions.keys.should == ['default', 'second']
#    end
#  end
#end
#
#
#describe "TestSession2: BrowserSession when there are 2 browsers on the desktop and corresponding session records" do
#  context "reuse default browser without running test1" do
#    it 'reuse should attach to browser started in previous test session' do
#      ie = BrowserSession.reuse
#      ie.should be_kind_of(Watir::IE)
#      ie.close
#      ie.should_not exist
#    end
#    
#  end
#end