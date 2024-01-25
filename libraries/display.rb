class Display

    def initialize 
      # We are going to hardcode some things here :
      @history_size = 40
     
      @display_history = Array.new(@history_size, " ")

      @test_variable = 40

    end

    #-------------------------------
    
    def window(lower_range, upper_range)
    
        @display_history.slice(lower_range, upper_range)       

    end

    #-------------------------------

    def set_display(location, display_output, new_line = false)

        if location > @history_size-1
          location = @history_size-1
        end

        if !new_line
          @display_history[location] += display_output
        else
          @display_history[location] = display_output
        end
  
    end

    #-------------------------------

    def current_line()

      @display_history[@history_size-1]

    end

    #-------------------------------


    def add_to_history(message_string)

        history_counter = 0

        while history_counter < @history_size do

          temporary_string = @display_history[history_counter+1]
          @display_history[history_counter] = temporary_string
          history_counter += 1

        end

        @display_history[history_counter-1] = message_string


        # We'll keep this here for testing purposes :

        #counter = 0
        #@display_history.each{ |history_string|
        #    counter += 1
        #    puts "line #{counter}--> #{history_string}"   
        #}

    end

    #-------------------------------

    def reset_display()
        
        end_of_array = @display_history.length()-1

        for counter in 0..end_of_array
   
           @display_history[counter] = " "

        end

    end


end # Of class
