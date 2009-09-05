require 'spec/autorun'
require 'watirloo'



module Google
  include Watirloo::Page
  face :query do
    text_field(:name, 'q')
  end
  keyword(:query) { browser.text_field(:name, 'q') }

  face :search do
    button(:name, 'btnG')
  end

end



describe 'somethin ' do
  include Google

  it 'bla ' do
    query.set "watir"
    search.click
    page.text.should include("Watir")
    page.link(:text, /Watir - Wikipedia/).should exist
    
  end
end
