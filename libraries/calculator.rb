class Calculator

  def initialize
      @running_amount = ""
      @MATH_API = "http://api.mathjs.org/v4/?expr="
      @parenthesis_status = "CLOSED"

  end # Of method

#---------------------------------

  def calculate(expression, precision_setting = 0)

      url_encoded_expression = CGI.escapeURIComponent(expression)
      
      calculate_url = @MATH_API + url_encoded_expression

      result = HTTP.get(calculate_url).to_s

      @running_amount = result

      result

  end # Of method

#---------------------------------

def get_running_amount()

    @running_amount.to_s

end

  #---------------------------------

  def reset_running_amount()

    @running_amount = 0
    @running_amount.to_s
  
  end

#---------------------------------


end # Of class
