require 'watir'
# manages references to browsers we care about to run tests agains.
# Saves references to window handles internall to yaml file so we can reuse the browser for tests by reattaching to it between tests.
# you put reference to a browser in storage. Next time you run a test you can restore the browser's reference instead fo staring a new one. 
class Storage

  @@storage = File.join(File.dirname(__FILE__), "..", "config", "browser_storage.yml")
  
  class << self
    
    # hash of {key => IE.hwnd} to attach and reuse browsers
    # example: mapping = {:default=> 234567, :bla => 234234}
    def mapping
      @mapping ||= read_mapping
    end

    def file_path( file_path = nil )
      @@storage = file_path if file_path
      @@storage
    end

    # returns IE reference to a browser with a given key
    def browser(key='default')
      if key == 'default'
        @browser ||= attach_browser #reuse default wihtout reattaching
      else
        attach_browser key
      end
    end
    
    # add browser to storage for later reuse. by convention if you don't have any browsers it 
    # so you can later restore it and continue working with it.
    # pass either browser referene or the hwnd Fixnum
    def add(key='default', browser=Watir::IE.start)
      mapping[key] = browser.kind_of?(Watir::IE) ? browser.hwnd : browser
      save_mapping
    end
    
    # remove browser from storage and from further reusing
    def remove(key='default')
      @browser = nil if key == 'default'
      mapping.delete(key) if mapping[key]
      save_mapping
    end

    # clear Storage
    def clear
      @browser = nil
      mapping.clear
      save_mapping
    end
    
    private
    
    def read_mapping
      if FileTest.exists?(@@storage)
        YAML::load_file(@@storage) 
      else
        {} #empty hash if stores not created yet
      end
    end
    
    def save_mapping
      File.open(@@storage,'w') {|f| YAML.dump(mapping, f)}
    end
    
    def attach_browser(key='default')
      Watir::IE.attach(:hwnd, mapping[key])
    end

  end
end


# Given there are no browser on the desktop run this test
require 'spec'
require 'spec/autorun'

describe "Storage for browsers so we can reattach to them later for tests" do

  def remove_storage_file
    #require 'FileUtils'
    FileUtils.rm_f(Storage.file_path) if FileTest.exist?(Storage.file_path)
  end

  before :all do
    remove_storage_file
  end

  after :all do
    remove_storage_file
  end
  
  context "storage file does not exist. create it" do

    it "mapping should return empty hash" do
      FileTest.exist?(Storage.file_path).should be_false
      Storage.mapping.should == {}

    end

    it "clear should create storage file save empty mapping" do
      Storage.clear
      FileTest.exist?(Storage.file_path).should be_true
      Storage.mapping.should == {}
    end
  end

  context "storage is empty. add new browser to storage" do

    it 'add stores ie.hwnd with friendly name and adds it to mapping accepts either ie or hwnd as value' do
      ie = Watir::IE.new
      Storage.add('one', ie)
      Storage.add('two', ie.hwnd)
    end

    it 'mapping holds what was added' do
      Storage.mapping.keys.sort.should == ['one', 'two']
      Storage.mapping['one'].should == Storage.mapping['two']
    end

    it 'remove deletes a key value record ' do
      Storage.remove 'two'
      Storage.mapping.keys.should_not include('two')
    end
  end

  context 'reattach to browser and close it' do
    it 'browser returns reference to named browser based on windows handle' do
      ie = Storage.browser 'one'
      ie.should be_kind_of(Watir::IE)
      ie.hwnd.should == Storage.mapping['one']
      ie.should exist
      ie.close
      ie.should_not exist
    end
  end

  context 'no browsers for records in storage' do
    it 'browser attach to nonexisting windows behaves like IE.attach, it raises error' do
      sleep 6 # if previous test closes a browser we need to wait to ensure we don't reattach to a closing browser
      (lambda {Storage.browser('one')}).should raise_error(Watir::Exception::NoMatchingWindowFoundException) #points to the same hwnd as 'one' but at this time does not exist any more
    end
  end

end


