

Given /^that we are on the Google Homepage$/ do
  browser.goto "http://google.com/"
end

When /^I search for (.*)$/ do |term|
  query.value = term
  search.click
end

Then /^I should see link (.*)$/ do |link_for_term|
  page.text.should include("Watir")
  #page.link(:text, /Watir - Wikipedia/).should exist
  page.link(:text, /#{link_for_term}/).should exist

end