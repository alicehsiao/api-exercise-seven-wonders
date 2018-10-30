require 'httparty'
require 'awesome_print'

class SevenWonders
  attr_accessor :wonder

  def initialize(wonder)
    @wonder = wonder
  end

  def get_coordinates
    coordinates = {}

    encoded_uri = URI.encode("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{@wonder}&inputtype=textquery&fields=geometry&key=AIzaSyBP30mYnbwKpZ0lCHtp6FuvcNSjNG0GsGM")

    response = HTTParty.get(encoded_uri)

    parsed_response = response.parsed_response

    coordinates["lat"] = parsed_response["candidates"][0]["geometry"]["location"]["lat"]
    coordinates["lng"] = parsed_response["candidates"][0]["geometry"]["location"]["lng"]

    return coordinates
  end
end


coordinate_hash = {}
seven_wonders = ["Great Pyramid of Giza", "Ishtar Gate", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

seven_wonders.each do |wonder|
  theWonder = SevenWonders.new(wonder)
  coordinate_hash[wonder] = theWonder.get_coordinates
end

ap coordinate_hash
