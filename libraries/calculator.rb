class Calculator

  def initialize
      @running_amount = 0
      @decimal_used = false
  end # Of method

#---------------------------------

  def add_numbers(number)

    if @running_amount == 0
      @running_amount = number
    else
      @running_amount += number
    end

  end # Of method

  #---------------------------------

  def subtract_numbers(number)

    if @running_amount == 0
      @running_amount = number
    else
      @running_amount -= number
    end

  end # Of method

end # Of class
