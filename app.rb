require "sinatra"
require "sinatra/reloader"
require "./libraries/calculator.rb"  # For our calculator object.
require "./libraries/display.rb"     # For our display.

@display_array = Array.new(8)
upper_display_range = 39
lower_display_range = 32

calc_display = Display.new

calc_start = true

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

get("/:calc_input/:calc_mode") do

    calc_input = params.fetch("calc_input")
    calc_mode = params.fetch("calc_mode")


    if calc_start 

      calc_display.add_to_history(calc_input)
      calc_start = false
    
    end

    current_line = calc_display.current_line()

    case calc_input

      when "EQU"
        calc_display.add_to_history(current_line)
        calc_input = " "
        calc_display.set_display(upper_display_range, calc_input, true)
          
      when "AC"
        calc_display.reset_display()





    end

    calc_display.set_display(upper_display_range, calc_input)


    case calc_mode

      when "basic"
        redirect("/basic")
      when "sci"
        redirect("/scientific")

    end


end

#get("/basic_functions") do

#end
