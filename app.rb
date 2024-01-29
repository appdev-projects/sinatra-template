require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "uri"
require "./libraries/calculator.rb"  # For our calculator object.
require "./libraries/display.rb"     # For our display.

MATH_API = "http://api.mathjs.org/v4/?expr="

@display_array = Array.new(8)
lower_display_range = 0
upper_display_range = 7

calc_display = Display.new
calc_object = Calculator.new

calc_start = true

get("/") do

  # We do this only once, to welcome the user :

  calc_display.add_to_history("Welcome to OMNICALC4 !!")
  calc_display.add_to_history("Have fun !!")

  redirect("/basic")
  
end

#-------------------------------------------------

get("/process_calc/:input_data") do

    input_data = params.fetch("input_data")

    input_array = input_data.split(":")

    calc_input = " "
    
    calc_input = input_array[0]
    calc_mode = input_array[1]

#-------------------------------------------------
# We will be defining out input processing here :

    case calc_input

      # Simple math :

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

      # Math functions :

      when "POW"
        calc_input = "pow("

      when "SQR"
        calc_input = "sqrt("

      when "NTHRT"
        calc_input = "nthRoots("

      when "LOG"
        calc_input = "log("

      when "TENPOW"
        calc_input = "pow(10,"

      when "NEGTENPOW"
        calc_input = "pow(10,-"

      when "SIN"
        calc_input = "sin("

      when "COS"
        calc_input = "cos("

      when "TAN"
        calc_input = "tan("

      when "INVSIN"
        calc_input = "asin("

      when "INVCOS"
        calc_input = "acos("

      when "INVTAN"
        calc_input = "atan("

      when "RECIP"
        calc_input = "1/"

      when "FACTOR"
        calc_input = "factorial("

      when "MOD"
        calc_input = "mod("


      # Constants :
      when "E"
        calc_input = "2.718"

      when "PI"
        calc_input = "3.141"


      # "Auxilliary" buttons :

      when "CLEAR"
        calc_display.add_to_history(" ")
        calc_input = ""

      when "AC"
        calc_display.reset_display
        calc_input = ""

      
      # Non-numeric characters :

      when "OPENPAREN"
        calc_input = "("

      when "CLOSEPAREN"
        calc_input = ")"

      when "COMMA"
        calc_input = ","

#----------------------------------------------------

      when "EQU"

        expression = calc_display.history_line(upper_display_range)
        output = calc_object.calculate(expression)
        calc_display.add_to_history(output)
        calc_input = ""

    end
    
#----------------------------------------------
    if calc_start 
      calc_display.add_to_history(calc_input)
      calc_start = false
    
    else 
      calc_display.set_display(upper_display_range, calc_input)

    end    

#-------------------------------------------
    
    case calc_mode

        when "BAS"
          redirect("/basic")

        when "SCI"
          redirect("/scientific")

        when "GPT"
          redirect("/gpt")

    end

end

#-------------------------------------------


get("/basic") do

  upper_display_range = 39
  lower_display_range = 32

  @display_array = calc_display.window(lower_display_range, upper_display_range)

  erb(:basic_calculator)

end

#-------------------------------------------


get("/scientific") do

  upper_display_range = 39
  lower_display_range = 32

  @display_array = calc_display.window(lower_display_range, upper_display_range)

  erb(:sci_calculator)

end


#-------------------------------------------

get("/gpt") do

  @display_array = calc_display.window(lower_display_range, upper_display_range)

  erb(:gpt_calculator)

end
