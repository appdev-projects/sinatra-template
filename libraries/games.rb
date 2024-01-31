# For Hangman : generate random word : 
# https://random-word-api.vercel.app/api?words=1

class Games

    def initialize

        @max_x = 38
        @max_y = 12
        @game_display_array = Array.new(@max_y)
        @game_done = "no"

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

         @spots = [["*","*","*"],["*","*","*"],["*","*","*"]]
         @x_img = Array[" X X", "  X ", " X X"] 
         @o_img = Array[" OO ", "O  O", " OO "]
         @game_board = Array[" 0000 | 1111 | 2222 ", 
                             "------|------|------"]
         @draw_x_loc = 5

         super

    end

#-------------------------------------------------------

    def reset_game

        @spots = [
            ["*","*","*"],
            ["*","*","*"],
            ["*","*","*"]
        ]

    end

#-------------------------------------------------------

    def render_game_board

        row_counter = 0
        column_counter = 0

        line_counter = 0

        temp_string_array = Array.new(3)
        temp_string_array[0] = @game_board[0] 
        temp_string_array[1] = @game_board[0] 
        temp_string_array[2] = @game_board[0] 

        while row_counter != 3 do
            while column_counter != 3 do

                string_to_find = column_counter.to_s*4

                if @spots[row_counter][column_counter] == "X"
                    for indx in 0..2
                        temp_string_array[indx] = temp_string_array[indx].sub(string_to_find, @x_img[indx])
                    end

                elsif @spots[row_counter][column_counter] == "O"         
                    for indx in 0..2
                        temp_string_array[indx] = temp_string_array[indx].sub(string_to_find, @o_img[indx])
                    end

                else 
                    for indx in 0..2
                        temp_string_array[indx] = temp_string_array[indx].sub(string_to_find, "    ")
                    end

                end # Of condition block

                column_counter += 1

            end # Of inner while ( column )
              

            for indx in 0..2
                @game_display_array[line_counter] = " "*@draw_x_loc+temp_string_array[indx]
                line_counter += 1

            end
        
            if row_counter < 2
                @game_display_array[line_counter] = " "*@draw_x_loc+@game_board[1]
                line_counter += 1
            end
            
            column_counter = 0
            row_counter += 1

            temp_string_array[0] = @game_board[0] 
            temp_string_array[1] = @game_board[0] 
            temp_string_array[2] = @game_board[0] 

        end # Of outer while ( row )

        #self.print_message(25, 1, "Test message")

        #@game_display_array.each do |display_line|
        #    puts "--->#{display_line}<--"
        #end


        if self.is_draw()
            self.print_message(25, 4, "DRAW GAME")
            @game_done = "yes"

        elsif 
            self.winner_result("X") == "yes"
            self.print_message(25, 4, "X WINS!!")
            @game_done = "yes"

        elsif 
            self.winner_result("O") == "yes"
            self.print_message(25, 4, "O WINS!!")
            @game_done = "yes"

        end


        @game_display_array
        
    end # Of method

#-------------------------------------------------------

    def winner_result(mark)

       is_winner = "no"

       played_array = @spots.flatten

       winning_combos = ["012","345","678","036","147","258","048","246"]

       winning_combos.each do |three_indices|

           if is_winner == "no"
               counter = 0
               three_indices.each_char do |index|

              
                  if played_array[index.to_i] != mark
                    break
                  else 
                    counter += 1
                  end # Of condition block

               end # Of three_indices loop

               if counter == 3
                  is_winner = "yes"
               end # Of winner check condition

            end # Of winner condition

       end # Of winning_combos loop

       is_winner
  

    end # Of method

#-------------------------------------------------------

    def is_draw()

        played_array = @spots.flatten

        not played_array.include?("*")

    end



#-------------------------------------------------------

    def move(row, column, mark)
        @spots[row.to_i][column.to_i] = mark
    end

#-------------------------------------------------------

    def computer_move()

      rand_num = Random.new

      random_row = rand_num.rand(0..2)
      random_column = rand_num.rand(0..2)

      while self.check_spot(random_row, random_column) == "yes" && @game_done == "no"

        random_row = rand_num.rand(0..2)
        random_column = rand_num.rand(0..2)
  
      end

      self.move(random_row, random_column, "O")
      

    end

#-------------------------------------------------------

    def check_spot(row, column)

       space_occupied = "yes"

       puts "TEST #{@spots[row.to_i][column.to_i]}"

       if @spots[row.to_i][column.to_i] == "*"

           space_occupied = "no"

       end

       space_occupied

    end

end # Of class

#=============================================================
#   |------ 
#   |     O
#   |    O O
#   |     O
#   |     | 
#   |    /|\ 
#   |   / | \
#   |     |
#   |    / \
#   |   /   \
#   |            _ A _ _ _ _ _ _ C _ _ _ _ _ _
#_______

class Hangman < Games

    def initialize

        @word_url = "https://random-word-api.vercel.app/api?words=1"
        @hang_counter = 0


    end

#-------------------------------------------------------

    def draw_gallows
    
        puts "GALLOWS DRAWN"

    end

#-------------------------------------------------------

    def draw_man

      case @hang_counter
        when 1
          # Draw the head
          puts "HEAD"
      
        when 2
          # Draw the body
          puts "BODY"

        when 3
          # Draw the left arm
          puts "LEFT ARM"
        
        when 4
          # Draw the right arm
          puts "RIGHT ARM"

        when 5
          # Draw the left leg
          puts "LEFT LEG"

        when 6
          # Finally, draw the right leg
          puts "RIGHT LEG, HE IS HUNG !!"
    
      end  


    end

end # Of class
