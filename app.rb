require "sinatra"
require "sinatra/reloader"
require 'open-uri'
require "json"



get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get '/get_user_location' do
  content_type :json

  # Replace YOUR_GOOGLE_API_KEY with your actual Google Geolocation API key.
  api_key = 'YOUR_GOOGLE_API_KEY'

  # Get the user's IP address from the request object.
  user_ip = request.ip

  # Construct the Google Geolocation API URL.
  url = "https://www.googleapis.com/geolocation/v1/geolocate?key=#{api_key}"

  # Make a POST request to the Google Geolocation API.
  response = JSON.parse(open(url, method: :post).read)

  # Return the location data as a JSON response.
  {
    latitude: response['location']['lat'],
    longitude: response['location']['lng'],
    accuracy: response['accuracy']
  }.to_json
end
