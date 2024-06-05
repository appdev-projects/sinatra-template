require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'

def getRecipe(search_term)
  API_ID = ENV.fetch("API_ID")
  API_KEY = ENV.fetch("API_KEY")
  url = URI("https://api.edamam.com/api/recipes/v2?type=public&q=#{search_term}&app_id=0443a169&app_key=1ee0cbfaf95acc2db0be467e463a22ba")
  response = Net::HTTP.get(url)
  response_obj = JSON.parse(response)
  results = response_obj.fetch("hits")
end


get("/") do

  erb(:home)
end

post("/recipe_search") do

  search_term = params.fetch("search_term")
  @results = getRecipe(search_term)

  erb(:recipe)
end
