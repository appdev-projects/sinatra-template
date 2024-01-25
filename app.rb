require "sinatra"
require "sinatra/reloader"
require "./libraries/calculator.rb"  # For our calculator object.
require "./libraries/display.rb"     # For our display.

@display_array = Array.new(8)
upper_display_range = 39
lower_display_range = 32

calc_display = Display.new

get("/") do

  # We do this only once, to welcome the user :

  calc_display.add_to_history("Welcome to OMNICALC4 !!")
  calc_display.add_to_history("Have fun !!")

  redirect("/basic")
  
end

get("/basic") do

  @display_array = calc_display.window(lower_display_range, upper_display_range)

  erb(:basic_calculator)

end

#get("/basic_functions") do

#end
