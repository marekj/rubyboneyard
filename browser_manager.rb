require 'watir'
# The manager
# checks to see what browsers already exist on the dekstop.
# compares what is on the desktop to what is in the storage
# not really. maybe just take a look at what's on the desktop.
class Desktop

  class << self
    # returns browsers found on the desktop
    def browsers
      brs =[]
      Watir::IE.each {|ie| brs << ie }
      brs
    end

    def hwnds
      hs =[]
      browsers.each {|ie| hs << ie.hwnd}
      hs
    end

    def additions(known_hwnds)
      hwnds.select {|h| !known_hwnds.include?(h)}
    end

    def deletions(known_hwnds)
      known_hwnds.select {|h| !hwnds.include?(h)}
    end

    def clear
      Watir::IE.each {|ie| ie.close}
      sleep 3
      raise Exception, "Failed to clear all the browsers from the desktop" unless browsers.empty?
    end

  end
end



require 'spec/autorun'


describe "Browsers on the Desktop" do
  context "clear desktop of all browsers and start one browser" do
    it "clear closes all browsers on the desktop. browsers should be empty" do
      Desktop.clear
      Desktop.browsers.should be_empty
    end

    it "adding first browser should report 1 addition and no deletions" do
      hwnds = Desktop.hwnds
      Watir::IE.start
      added = Desktop.additions(hwnds)
      added.size.should == 1
      Desktop.deletions(hwnds).should be_empty
    end
  end

  context "start with one browser and add a new one" do
    it 'while one browser on the desktop the additions and deletions should be false' do
      hwnds = Desktop.hwnds
      hwnds.size.should == 1
      Desktop.additions(hwnds).should be_empty
      Desktop.deletions(hwnds).should be_empty
    end

    it 'adding second browser should report one addition and no deletions' do
      hwnds = Desktop.hwnds
      Watir::IE.start
      Desktop.additions(hwnds).size.should == 1
      Desktop.deletions(hwnds).should be_empty
      Desktop.hwnds.size.should == 2
    end

  end

  context "start with 2 browsers, close one and end up with one" do
    it 'close one should report 1 deletion and no additions, attempt to attach to deleted cause exception' do
      hwnds = Desktop.hwnds
      Desktop.browsers[0].close #close any
      Desktop.additions(hwnds).should be_empty
      deleted = Desktop.deletions(hwnds)
      deleted.size.should == 1
      lambda{ Watir::IE.attach :hwnd, deleted[0]}.should raise_error
    end

  end
  
  context "while one browser on desktop, close it and start new one." do
    it "should report one addition and one deletion" do
      hwnds = Desktop.hwnds
      hwnds.size.should == 1
      Watir::IE.start
      (Watir::IE.attach(:hwnd, hwnds[0])).close
      sleep 5
      Desktop.additions(hwnds).size.should == 1
      Desktop.deletions(hwnds).size.should == 1
    end
  end
end