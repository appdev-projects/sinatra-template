require "sinatra"
require "sinatra/reloader"

get("/") do
  
  erb(:basic_calculator)


end
