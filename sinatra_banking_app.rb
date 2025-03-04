require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:home)
end

get("/process_roll?") do
  @num_dice = params.fetch("dice")
  @num_sides = params.fetch("sides")
  
 
  @rolls = []

  @num_dice.to_i.times do 
    die = rand(1..@num_sides.to_i)

    @rolls.push(die)
  end

  
  erb(:process_roll)
end
class BankAccount
  attr_reader :balance

  def initialize
    @balance = 0.0
    return
  end

  def deposit
    puts "Please enter the amount you would like to deposit: "
    amount = gets.chomp.to_f
    while amount < 1
      "ERROR: Please enter a value greater than 0: "
      amount = gets.chomp.to_f
    end
    @balance = @balance + amount.to_f
    puts "Your transaction was succesfully completed. Your new balance is: $" + @balance.to_s
    puts "Please press Enter to proceed..."
    waiting_for_user_input = gets
    return
  end

  def withdraw
    puts "Please enter the amount you would like to withdraw from: $" + @balance.to_s
    amount = gets.chomp.to_f
    while @balance - amount < 0
      puts "Oops! The amount you entered is too high. Please enter an amount at or below: $" + @balance.to_s + ", then press Enter."
      amount = gets.chomp.to_f
    end
    @balance = @balance - amount.to_f
    puts "Your transaction was successfully completed. Your new balance is: $" + @balance.to_s
    puts "Please press Enter to proceed..."
    waiting_for_user_input = gets
    return
  end

  def show_balance
    return @balance
  end

  def deposit_test(amount)
    @balance = @balance + amount.to_f
    return @balance
  end

  def withdraw_test(amount)
    @balance = @balance - amount.to_f
    return @balance
  end
end

# array used to contain created new BankAccount objects
@accounts = []

# variables used to store menu selection number and account number
selection = 1
account_number = 0

# begin program
while selection > 0 && selection < 6
  puts "Welcome to your Online Bank Account: What would you like to do today?"
  puts "Create Account: 1"
  puts "Check Balance: 2"
  puts "Make a Deposit: 3"
  puts "Make a Withdrawal: 4"
  puts "Close Account: 5"
  puts "Quit application: 6"

  selection = gets.chomp.to_i
  while selection < 1 || selection > 6
    puts "Oops! You can only enter a selection between 1-6. Please try again."
    selection = gets.chomp.to_i
  end

  if selection == 1
    temp = BankAccount.new
    @accounts.push(temp)
    puts "Congratulations!! Your NEW bank account number is: " + @accounts.length.to_s
    puts "Please remember your account number, then press Enter to proceed"
    waiting_for_user_input = gets
  elsif selection == 2
    puts "Please enter your account number:"
    account_number = gets.chomp
    if account_number.to_i == 0 || !account_number.to_s.match(/\d/) || @accounts[account_number.to_i - 1].nil?
      puts "ERROR!! Invalid bank account number. Please enter a valid account number, or Create a new account."
      puts "Please press Enter to proceed.."
      waiting_for_user_input = gets
    else
      puts "Your account balance is: " + @accounts[account_number.to_i - 1].show_balance.to_s
      puts "Please press Enter to proceed..."
      waiting_for_user_input = gets
    end
  elsif selection == 3
    puts "Please enter your account number:"
    account_number = gets.chomp
    if account_number.to_i == 0 || !account_number.to_s.match(/\d/) || @accounts[account_number.to_i - 1].nil?
      puts "ERROR!! Invalid bank account number. Please enter a valid account number, or Create a new account."
      puts "Please press Enter to proceed.."
      waiting_for_user_input = gets
    else
      @accounts[account_number.to_i - 1].deposit
    end
  elsif selection == 4
    puts "Please enter your account number:"
    account_number = gets.chomp
    if account_number.to_i == 0 || !account_number.to_s.match(/\d/) || @accounts[account_number.to_i - 1].nil?
      puts "ERROR!! Invalid bank account number. Please enter a valid account number, or Create a new account."
      puts "Please press Enter to proceed.."
      waiting_for_user_input = gets
    else
      @accounts[account_number.to_i - 1].withdraw
    end
  elsif selection == 5
    puts "Please enter your account number:"
    account_number = gets.chomp
    if account_number.to_i == 0 || !account_number.to_s.match(/\d/) || @accounts[account_number.to_i - 1].nil?
      puts "ERROR!! Invalid bank account number. Please enter a valid account number, or Create a new account."
      puts "Please press Enter to proceed.."
      waiting_for_user_input = gets
    elsif @accounts[account_number.to_i - 1].show_balance.to_f > 0
      puts "Information! You still have a balance remaining in your account: $" + @accounts[account_number.to_i - 1].show_balance.to_s + ". You must have a zero balance in your account before closing it."
      puts "Please press Enter to proceed.."
      waiting_for_user_input = gets
    else
      @accounts[account_number.to_i - 1] = nil
      puts "Your account was successfully closed. Have a great day!"
      puts "Please press Enter to proceed..."
      waiting_for_user_input = gets
    end
  elsif selection == 6
    puts "Thank you for banking with us. Have a great holiday season!"
    return
  else puts "ERROR: Please enter a whole number between 1-5. Press enter key to try again."
    wait_for_user_input = gets.chomp.to_i
    selection = 1   
  end
end
