require "sinatra"
require "http"
require "json"

get("/") do
  redirect("/advice")
end

get "/advice" do
  raw_response = HTTP.get("https://api.adviceslip.com/advice")
  advice_data = JSON.parse(raw_response)
  @advice = advice_data.fetch("slip").fetch("advice")
  erb(:advice)
end
