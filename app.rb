require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "httparty"

Geocoder.configure(ip_lookup: :ipinfo_io)

get("/") do
  erb :index
end

def get_movies_nearby(latitude, longitude)
  tmdb_api_key = ENV['TMDB_API_KEY']

  url = "https://api.themoviedb.org/3/movie/now_playing"
  params = {
    api_key: tmdb_api_key,
    language: 'en-US',
    page: 1,
    region: 'US', 
    lat: latitude,
    lng: longitude
  }

  response = HTTParty.get(url, query: params)

  puts "API Response:"
  puts JSON.parse(response.body)['results']

  if response.code == 200
    return JSON.parse(response.body)['results']
  else
    return []
  end
end

get("/movies") do
  @latitude = params[:lat]
  @longitude = params[:lng]

  @latitude ||= 0.0
  @longitude ||= 0.0
  
  @movies_nearby = get_movies_nearby(@latitude, @longitude)

  erb :movies
end
