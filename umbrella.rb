# Write your soltuion here!

require "http"
require "json"
require "dotenv/load"
pw_api_key = ENV.fetch("PIRATE_WEATHER_API_KEY")
gmaps_key = ENV.fetch("GMAPS_KEY")

pp "Hello where are you?"

my_location = gets.chomp
##my_location = "The White House"
pp "Checking the weather in #{my_location}...."
google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{my_location}&key=#{gmaps_key}"
raw_body = HTTP.get(google_maps_url).to_s
require "json"
raw_body;
parsed_body = JSON.parse(raw_body);
results_array = parsed_body.fetch("results")
first_result = results_array.at(0)
geometry_hash = first_result.fetch("geometry")
location_hash = geometry_hash.fetch("location")
lat = location_hash.fetch("lat")
lng = location_hash.fetch("lng")


 pirate_weather_url = "https://api.pirateweather.net/forecast/#{pw_api_key}/#{lat},#{lng}"
raw_response = HTTP.get(pirate_weather_url)
parsed_response = JSON.parse(raw_response)
hourly_data_array = parsed_response.fetch("hourly").fetch("data")
currently_hash = parsed_response.fetch("currently")
current_temp = currently_hash.fetch("temperature")

puts "Your coordinates are #{lat},#{lng}."
puts "The current temperature is #{current_temp}."


def extract_time_and_precip(hourly_data_array)
  time_precip_hash = {}
  hourly_data_array.each do |hour_hash|
    time_stamp = hour_hash.fetch("time")
    precip_probability = hour_hash.fetch("precipProbability")
    time_precip_hash.store(time_stamp, precip_probability)
  end
  return time_precip_hash
end

result_hash = extract_time_and_precip(hourly_data_array)

first_nonzero_pair = result_hash.find do |timestamp, value|
  value > 0
end

if first_nonzero_pair
  # Use .at() to retrieve the timestamp from the resulting array
  first_timestamp = first_nonzero_pair.at(0)
  pp "Grab an umbrella, it will rain in approximately #{(Time.at(first_timestamp) - Time.now).round(0)/60} minutes"
elsif
    pp "No need for an umbrella! No rain predicted today! :)"
end
