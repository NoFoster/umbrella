# Write your soltuion here!

require "http"
require "json"
require "dotenv/load"
pw_api_key = ENV.fetch("PIRATE_WEATHER_API_KEY")
gmaps_key = ENV.fetch("GMAPS_KEY")

pp "Hello where are you?"

##my_location = gets.chomp
my_location = "Chicago Booth Harper Center"

google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{my_location}&key=#{gmaps_key}"
raw_body = HTTP.get(google_maps_url).to_s
require "json"
raw_body;
parsed_body = JSON.parse(raw_body);
results_array = parsed_body.fetch("results")
first_result = results_array.at(0)
geometry_hash = first_result.fetch("geometry")
location_hash = geometry_hash.fetch("location")
pp lat = location_hash.fetch("lat")
pp lng = location_hash.fetch("lng")

###addy.fetch("address_components")
##lat = addy.fetch("navigation_points")
#raw_response = HTTP.get(pirate_weateher_url)
