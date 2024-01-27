require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "uri"
require "./libraries/calculator.rb"  # For our calculator object.
require "./libraries/display.rb"     # For our display.

MATH_API = "http://api.mathjs.org/v4/?expr="

@display_array = Array.new(8)
upper_display_range = 39
lower_display_range = 32

calc_display = Display.new
calc_object = Calculator.new

calc_start = true

get("/") do

  # We do this only once, to welcome the user :

  calc_display.add_to_history("Welcome to OMNICALC4 !!")
  calc_display.add_to_history("Have fun !!")
  calc_display.add_to_history(" ")
  

  redirect("/basic")
  
end

get("/basic") do

  @display_array = calc_display.window(lower_display_range, upper_display_range)

  erb(:basic_calculator)

end

get("/:input_data") do

    input_array = params.fetch("input_data").split(":")
    
    calc_input = input_array[0]
    calc_mode = input_array[1]
    is_operation = input_array[2]

#-------------------------

    case calc_input

      when "DIV"
        calc_input = "/"

      when "MUL"
        calc_input = "*"

      when "ADD"
        calc_input = "+"

      when "SUB"
        calc_input = "-"

      when "PERCENT"
        calc_input = "%"

      when "DEC"
        calc_input = "."

      when "CLEAR"
        calc_display.add_to_history(" ")
        calc_input = ""

      when "AC"
        calc_display.reset_display
        calc_input = ""

      when "EQU"
        output = calc_object.calculate(calc_display.history_line(upper_display_range))
        calc_display.add_to_history(output)
        calc_input = ""

    end
    
#-------------------------
    if calc_start 
      calc_display.add_to_history(calc_input)
      calc_start = false
    
    else 
      calc_display.set_display(upper_display_range, calc_input)

    end    

#-------------------------
    case calc_mode

        when "basic"
          redirect("/basic")
        when "sci"
          redirect("/scientific")

    end

end
