require 'watirloo'
require 'pp'

module Page2
  def browser
    @browser ||= Watirloo.browser
  end
end

class UseCase #self for keeping state

  include Page2 # provides default browser

  def initialize *args
    options = args.last if args
    if options && options[:browser]
      @browser = options[:browser]
    end
  end
end

# browser explicitly provided
uc = UseCase.new :browser => Watirloo.browser(:outsider)
pp uc.browser

# default browser from Page2 module
uc = UseCase.new
pp uc.browser

Watirloo.browser(:outsider).close
Watirloo.browser.close
