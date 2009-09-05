ENV["LOCAL_GEM"] = 'override' # turns on local_gem

if ENV['LOCAL_GEM']
  require 'local_gem'
  require 'local_gem/override'

  LocalGem.setup_config(nil) do |conf|
    conf.gems = {
      'watir' => [
        "C:/code/github/watir/commonwatir/lib",
        "C:/code/github/watir/watir/lib"
      ],
      'firewatir' => 'c:/code/github/watir/firewatir/lib',
      'watirloo' => "C:/code/github/watirloo/lib",
      'watircraft' => [
        "C:/code/github/watircraft/lib",
        "C:/code/github/watircraft/bin"
      ]
    }
  end
end


if ENV['LOCAL_GEM']
  require 'local_gem'
  require 'local_gem/override'
  LocalGem.setup_config(nil) do |c|
    c.gems = {
      'watir' => [
        "C:/DATA/PRIVATE/code/github_marekj/watir/commonwatir/lib",
        "C:/DATA/PRIVATE/code/github_marekj/watir/watir/lib"
      ],
      'watirloo' => "C:/DATA/PRIVATE/code/github_marekj/watirloo/lib"
    }
  end
end



require 'watirloo'
puts Watir::IE::VERSION
#exit

require 'watir'
require 'watir/ie'
puts Watir::IE::VERSION