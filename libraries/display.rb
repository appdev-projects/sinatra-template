class Display

    def initialize 
      # We are going to hardcode some things here :
      @history_size = 40
     
      @display_history = Array.new(@history_size, " ")

      puts ("INSIDE CLASS DISPLAY :")

    end

    #-------------------------------
    
    def show_window(upper_range, lower_range)
    
        @display_history.slice(lower_range, upper_range)       

    end

    #-------------------------------

    def set_display(location, display_output)

        if location < @history_size
          @display_history[location] = display_output
        end

    end

    #-------------------------------

    def add_to_history(message_string)

        puts "Adding to history :"

        history_counter = 0
        
        while history_counter < @history_size-1 do

          temporary_string = @display_history[history_counter+1]
          @display_history = temporary_string
          history_counter += 1

        end

        @display_history[@history_size-1] = message_string

        # We'll keep this here for testing purposes :
        @display_history.each{ |history_string|
            puts "--> #{history_string}"   
        }

    end

    #-------------------------------


end # Of class
