# For Hangman : generate random word : 
# https://random-word-api.vercel.app/api?words=1

class Games

    def initialize

        @max_x = 38
        @max_y = 12
        @game_display_array = Array.new(@max_y)
        @game_done = "no"

        @move_array = [0, 1, 2, 3, 4, 5, 6, 7, 8]

        self.clear_game_grid

    end

#-------------------------------------------------------

    def render_char_at(x_loc, y_loc, render_char)

        if @max_x > x_loc && @max_y > y_loc
          
            temp_string = @game_display_array[y_loc]
            temp_string[x_loc] = render_char
            @game_display_array[y_loc] = temp_string

        end


    end

#-------------------------------------------------------

    def print_message(x_loc, y_loc, message)

        x_counter = 0

        message.each_char do |individual_char|
            self.render_char_at(x_loc+x_counter, y_loc, individual_char)
            x_counter += 1
        end

    end

#-------------------------------------------------------

    def clear_game_grid()

        line_counter = 0

        while line_counter < @max_y do

          @game_display_array[line_counter] =  " "*@max_x   
          line_counter += 1
 
        end

    end

#-------------------------------------------------------

    def get_game_grid()

      @game_display_array

    end


end # Of class.

#=============================================================

class Tic_tac_toe < Games

    def initialize

         @x_img = Array["X X "," X  "] 
         @o_img = Array[" OO ","O  O"]
         @game_board = " E000 | E111 | E222 : M000 | M111 | M222 : E000 | E111 | E222 : ------|------|------ : E333 | E444 | E555 : M333 | M444 | M555 : E333 | E444 | E555 : ------|------|------: E666 | E777 | E888 : M666 | M777 | M888 : E666 | E777 | E888 "
         @draw_x_loc = 5

         @move_array = [0, 1, 2, 3, 4, 5, 6, 7, 8]

         @user_move = []
         @computer_move = []

         @turn = "user"
         @game_done = "no"

         super

    end

#-------------------------------------------------------

    def reset_game

        @move_array = [0, 1, 2, 3, 4, 5, 6, 7, 8]

        @user_move = []
        @computer_move = []

        @game_board = " E000 | E111 | E222 : M000 | M111 | M222 : E000 | E111 | E222 :------|------|------ : E333 | E444 | E555 : M333 | M444 | M555 : E333 | E444 | E555 :------|------|------: E666 | E777 | E888 : M666 | M777 | M888 : E666 | E777 | E888 "


        @turn = "user"

        @game_done = "no"

    end

#-------------------------------------------------------

    def player_move(row, column)

        move_num = row*3+column
        
        if move_available(move_num)
            @user_move << move_num
            @move_array.delete(move_num)
            @turn = "computer"
        end 

    end

#-------------------------------------------------------

    def computer_move

        if @turn == "computer"

            random_number = @move_array.sample

            random_row = random_number / 3
            random_column = random_number % 3
        
            @move_array.delete(random_number)

            @computer_move << random_number

            @turn = "user"

        end


    end

#-------------------------------------------------------

    def get_game_state

        state_message = "no_wins"

        if is_draw == "yes"
            state_message = "Draw"

        elsif is_win(@user_move) == "yes" 
            state_message = "You win"

        elsif is_win(@computer_move) == "yes"
            state_message = "Computer wins"

        end
        
        state_message

    end # Of method.

#-------------------------------------------------------

    def is_win(move_array)

        is_winner = "no"

        winning_combos = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

        winning_combos.each do |combo_number_array|

            intersecting_array = move_array & combo_number_array
            
            if intersecting_array.length == 3
                is_winner = "yes"
                @game_done = "yes"

                break
            end


        end # Of outer loop.

        is_winner

    end # Of method.


#-------------------------------------------------------

    def is_draw

        game_is_draw = "no"

        if @move_array.length == 0
            game_is_draw = "yes"
            @game_done = "yes"

        end

    end # Of method.

#-------------------------------------------------------

    def move_available(move_number)

        @move_array.include?(move_number)

    end # of method.

#-------------------------------------------------------
    
    def render_game_board


        #Reset board to be re-drawn

        @game_board = " E000 | E111 | E222 : M000 | M111 | M222 : E000 | E111 | E222 :------|------|------ : E333 | E444 | E555 : M333 | M444 | M555 : E333 | E444 | E555 :------|------|------: E666 | E777 | E888 : M666 | M777 | M888 : E666 | E777 | E888 "

        # Render user moves first :
        #@user_move
        #@computer_move
        #@game_board

        @user_move.each do |user_num|

            middle_repl_string = "M"+user_num.to_s*3
            edge_repl_string = "E"+user_num.to_s*3
            
            @game_board = @game_board.gsub(middle_repl_string, @x_img[1])
            @game_board = @game_board.gsub(edge_repl_string, @x_img[0])

        end # Of render loop.

       
        # Now the computer moves

        @computer_move.each do |comp_num|

            middle_repl_string = "M"+comp_num.to_s*3
            edge_repl_string = "E"+comp_num.to_s*3
            
            @game_board = @game_board.gsub(middle_repl_string, @o_img[1])
            @game_board = @game_board.gsub(edge_repl_string, @o_img[0])

        end # Of render loop.

        # Finally, clean up :

        counter = 0
        while counter < 9 do

            middle_repl_string = "M"+counter.to_s*3
            edge_repl_string = "E"+counter.to_s*3
            
            @game_board = @game_board.gsub(middle_repl_string, "    ")
            @game_board = @game_board.gsub(edge_repl_string, "    ")

            counter += 1

        end # Of render loop.

        @game_display_array = @game_board.split(":")

        #---------------TEST ONLY ------------------- :

        #@game_display_array.each do |display_line|
        #    puts "--> #{display_line}"
        #end # of test display

        #puts " "
        #puts " "
        #puts "Movement array ->>>> #{@move_array}"

        @game_display_array


    end # Of method.

#-------------------------------------------------------

    def game_done

        @game_done

    end

#-------------------------------------------------------



end # Of class

#=============================================================


class Hangman < Games

    def initialize

        @word_url = "https://random-word-api.vercel.app/api?words=1"
        @hang_counter = 0

        # For screen real estate purposes, let's limit the word length
        # to 14 letters :
        @ultimate_word_length = 14
        @correct_guess_counter = 0
        @picked_word = ""
        @guessed_word = ""

        super

    end

#-------------------------------------------------------

    def draw_gallows
    
        self.print_message(0,0, "   |-----|")

        for count in 1..8
            self.print_message(0,count, "   |")
        end

        self.print_message(0,9, "==|")


    end

#-------------------------------------------------------

    def draw_man

      case @hang_counter
        when 1
           # Draw head
           self.print_message(7, 1, "  O  ")
           self.print_message(7, 2, " O O ")
           self.print_message(7, 3, "  O  ")
      
        when 2
           # Draw the body
           self.print_message(7, 4, "  |  ")
           self.print_message(7, 5, "  |  ")
           self.print_message(7, 6, "  |  ")
           self.print_message(7, 7, "  |  ")

        when 3
           # Draw the left arm 
           self.print_message(7, 5, " /| ")
           self.print_message(7, 6, "/ | ")
        
        when 4
           # Draw the right arm
           self.print_message(7, 5, " /|\\")
           self.print_message(7, 6, "/ | \\")

        when 5
           # Draw the left leg
           self.print_message(7, 8, " /")
           self.print_message(7, 9, "/ ")

        when 6
           # Draw the right leg
           self.print_message(7, 8, " / \\")
           self.print_message(7, 9, "/   \\")
      end  


    end # Of method

#-------------------------------------------------------

    def pick_word

        @picked_word = HTTP.get(@word_url).to_s

        word = @picked_word

        word = word.gsub(/[^a-z ]/i, '')

        @picked_word = word

        word_length = word.length

        while word_length > @ultimate_word_length
            @picked_word = HTTP.get(@word_url)
        end

        temp_string = ""       

        word.each_char do |letter|
       
            temp_string += "_"

        end

        @guessed_word = temp_string


    end

#-------------------------------------------------------

    def draw_word 

        self.print_message(0, 11, @guessed_word)

    end # Of method

#-------------------------------------------------------

    def check_picked_letter(picked_letter)

        guessed_correctly = "no"

        picked_letter = picked_letter.upcase

        temporary_word = @picked_word.upcase
        temp_guessed_word = @guessed_word

        array_counter = 0
        temporary_word.each_char do |letter|

            if letter == picked_letter
                temp_guessed_word[array_counter] = picked_letter
                @correct_guess_counter += 1
                guessed_correctly = "yes"
    
            end
            array_counter += 1

        end # Of loop.

        #........................

        @guessed_word = temp_guessed_word

        if guessed_correctly == "no"
            @hang_counter += 1
        end


    end

#-------------------------------------------------------

    def win_or_lose

       win_lose = "dontknow"

       # Check to see if we lost :
       if @hang_counter == 6
           win_lose = "lost"
           @game_done = "yes"
           self.print_message(10, 5, "Sorry,")
           self.print_message(10, 6, "You were HANGED!!")
           self.print_message(0, 11, @picked_word.upcase)
       end

       if @correct_guess_counter == @picked_word.length
          win_lose = "won"
          @game_done = "yes"
          self.print_message(10, 5, "Congratulations,")
          self.print_message(10, 6, "No hanging this time!!")

       end 

       win_lose   


    end

#-------------------------------------------------------

    def reset_game

        @hang_counter = 0
        @correct_guess_counter = 0
        pick_word

        self.clear_game_grid

        @game_done = "no"


    end

#-------------------------------------------------------

    def update_screen

        # Let's draw the gallows and the unlucky guy :

        draw_gallows
        draw_man
        draw_word

        @game_display_array
     
    end # Of method

end # Of class
