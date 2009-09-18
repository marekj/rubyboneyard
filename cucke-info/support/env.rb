require "watirloo"

module Google
  include Watirloo::Page
  face :query do
    text_field(:name, 'q')
  end

  face :search do
    button(:name, 'btnG')
  end

end

World(Google)
#World {Google}