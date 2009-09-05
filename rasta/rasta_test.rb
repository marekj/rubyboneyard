#require 'rasta'
require 'rasta/fixture/rasta_fixture'

class GoogleSearch
  include Rasta::Fixture::RastaFixture
  
  attr_accessor :term

  def term_result
    "Watir - Overview"
  end


end


