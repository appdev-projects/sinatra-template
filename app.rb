require "sinatra"
require "sinatra/reloader"
require "./libraries/calculator.rb"  # For our calculator object.
require "./libraries/display.rb"



get("/") do

  # We do this only once, to welcome the user :
  #calc_display = new.Display

  #calc_display.add_to_history("Welcome to OMNICALC4 !!")
  #calc_display.add_to_history("Have fun !!")

  redirect("/basic")

end

get("/basic") do

  erb(:basic_calculator)

end

#get("/basic_functions") do

#end
