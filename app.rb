require "sinatra"
require "http"
require "json"

get("/") do
  redirect("/joke")
end

get("/joke") do
  raw_response = HTTP.get("https://api.chucknorris.io/jokes/random")
  joke_data = JSON.parse(raw_response)
  @joke = joke_data.fetch("value")
  erb :joke
end
