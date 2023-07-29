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
    lon: longitude
  }

  response = HTTParty.get(url, query: params)

  if response.code == 200
    return JSON.parse(response.body)['results']
  else
    return []
  end
end

get("/movies") do
  @latitude = params[:lat]
  @longitude = params[:lon]

  @movies_nearby = get_movies_nearby(@latitude, @longitude)

  erb :movies
end
