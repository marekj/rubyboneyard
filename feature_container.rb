=begin
so feature container is like a page where we include PageObjects into it.
Give them some data and so on
hm.... thinking

=end
require 'watir/ie'

module Watirloo

  # objects that appear on one or more pages that we want to interact with
  # to produce an outcome class
  module PageObjects

    def search_for(data)
      search_field.set data
      search_button.click
    end

    def search_field
      browser.text_field(:name, 'q')
    end

    def search_button
      browser.button(:name, 'btnG')
    end

    def browser
      @ie ||= Watir::IE.attach :url, /google/
    end


    #dom root dombase, dombranch, domleaf? domnode? the thing that is root to start from
    def container
      browser # by default it's the main browser
    end


  end

  # not bdd
  class Example
    include PageObjects

  end


end


require 'spec/autorun'



describe 'SearchGoogle' do

  include Watirloo::PageObjects

  it "tells me that by default the google search is blank" do
    puts @@bla
    data = 'google'
    search_field.set data
    search_button.click
  end

  it "just search" do
    search_for "google"
    
  end

  it 'clicks' do
    
  end

end

