require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "uri"
require "./libraries/calculator.rb"  
require "./libraries/display.rb"     
require "./libraries/games.rb"       

MATH_API = "http://api.mathjs.org/v4/?expr="

display_size = 12
lower_display_range = 0
upper_display_range = 7

@display_array = Array.new(display_size)

@calculator_mode = "basic"

calc_display = Display.new
calc_object = Calculator.new
calc_tictactoe = Tic_tac_toe.new
calc_hangman = Hangman.new

calc_start = true

#========================================================

#Test tic-tac-toe grid
game_choice = "tic-tac-toe"
calc_tictactoe.reset_game
calc_tictactoe.render_game_board


#========================================================
#========================================================

get("/") do

  # We do this only once, to welcome the user :

  calc_display.add_to_history("Welcome to OMNICALC4 !!")
  calc_display.add_to_history("Have fun !!")

  redirect("/basic")
  
end

#========================================================

get("/process_calc/:input_data") do

    input_data = params.fetch("input_data")

    input_array = input_data.split(":")

    calc_input = " "
    
    calc_input = input_array[0]
    calc_mode = input_array[1]

#-------------------------------------------------
# We will be defining out input processing here :

    case calc_input

      # Basic :

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

      # GPT
      when "UP"
        calc_input = ""

        if lower_display_range > 0
            lower_display_range -= 1
            upper_display_range -= 1
        end
        


      when "DOWN"
        calc_input = ""

        if upper_display_range < calc_display.get_history_size-1
            lower_display_range += 1
            upper_display_range += 1
        end

        

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

#----------------------------------------------
    
    case calc_mode

        when "BAS"
          redirect("/basic")

        when "SCI"
          redirect("/scientific")

        when "GPT"
          redirect("/gpt")

    end

end

#========================================================

post("/get_response") do

  gpt_message = params.fetch("gpt_message")

  calc_display.reset_display

  open_ai_api_key = ENV.fetch("OPEN_AI_KEY")

  request_headers_hash = {
    "Authorization" => "Bearer #{open_ai_api_key}",
    "content-type" => "application/json"
  }

  request_body_hash = {
    "model" => "gpt-3.5-turbo",
    "messages" => [
    {
      "role" => "user",
      "content" => "#{gpt_message}"
    }
   ]
  }

  request_body_json = JSON.generate(request_body_hash)

  raw_response = HTTP.headers(request_headers_hash).post(
        "https://api.openai.com/v1/chat/completions",
        :body => request_body_json
  ).to_s

  parsed_response = JSON.parse(raw_response, object_class: OpenStruct)

  gpt_response = parsed_response.choices[0].message.content   

  # Format and adjust the response on the screen so that it can be
  # read by the user.

  calc_display.format_and_display(gpt_response)

  lower_display_range = 0

  upper_display_range = display_size-1

  redirect("/gpt")

end


#========================================================

get("/basic") do

  upper_display_range = calc_display.get_history_size - 1
  lower_display_range = upper_display_range - display_size

  @calculator_mode = "basic"

  @display_array = calc_display.window(lower_display_range, upper_display_range)

  erb(:basic_calculator)

end

#========================================================


get("/scientific") do

  upper_display_range = calc_display.get_history_size - 1
  lower_display_range = upper_display_range - display_size

  @calculator_mode = "scientific"

  @display_array = calc_display.window(lower_display_range, upper_display_range)

  erb(:sci_calculator)

end


#========================================================

get("/gpt") do

  @display_array = calc_display.window(lower_display_range, display_size)

  @calculator_mode = "gpt"

  erb(:gpt_calculator)

end


#========================================================

get("/games") do

    if game_choice == "tic-tac-toe"

        calc_tictactoe.render_game_board

        calc_display.reset_display

        line_count = 0

        game_display = calc_tictactoe.render_game_board

        game_display.each do |display_line|

            calc_display.set_display(line_count, display_line)
            line_count += 1

        end      
#....................................
    elsif game_choice == "hangman"

        line_count = 0

        #calc_hangman.pick_word
        #calc_hangman.check_picked_letter("P")
        game_display = calc_hangman.update_screen

        game_display.each do |display_line|

          calc_display.set_display(line_count, display_line)
          line_count += 1

        end      

    end # Of condition block for hangman

    @calculator_mode = "games"
    
    @display_array = calc_display.window(0, display_size)

    @game_selected = game_choice

    erb(:games_calculator)
  
end

#========================================================

get("/reset_game") do

  if game_choice == "tic-tac-toe"

    calc_tictactoe.reset_game
    calc_tictactoe.render_game_board
    calc_display.reset_display
    
  elsif game_choice == "hangman"

    calc_hangman.reset_game

  end

  redirect("/games")

end

#========================================================

get ("/change_game/:game") do

  calc_display.reset_display

  game_choice = params.fetch("game")

  redirect("/reset_game")

end

#========================================================

get("/process_move/:row/:column") do

  row = params.fetch("row")
  column = params.fetch("column")

  if calc_tictactoe.check_spot(row, column) == "no"
    calc_tictactoe.move(row, column, "X")
    calc_tictactoe.computer_move
  end
  

  redirect("/games")

end

#========================================================

get("/process_choice/:picked_letter") do

    puts "CHOICES PROCESSED HERE"

end
