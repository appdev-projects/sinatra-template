require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:home_page)
end

# get("/red") do
#   mood_words = ["urgent", "angry", "important", "mcdonalds", "emergency", "danger"]
#   @mood_word = mood_words.sample
#   erb(:red)
# end

# get("/yellow") do
#   mood_words = ["easy", "happy", "golden", "banana", "minion", "star"]
#   @mood_word = mood_words.sample
#   erb(:yellow)
# end

# get("/blue") do
#   mood_words = ["sad", "glad", "blue", "sky", "sea", "calm"]
#   @mood_word = mood_words.sample
#   erb(:blue)
# end

# Step 1: Create a new route that can accept a dynamic value for color in the url (i.e. mypage.com/color/red or mypage.com/color/yellow)
get("/color/:my_color") do
  # /color/zebra
  # {"my_color"=>"zebra"}
  @my_color = params['my_color'].downcase
  if @my_color == "blue"
    @mood_word = ["sad", "glad", "blue", "sky", "sea", "calm"].sample
  elsif @my_color == "red"
    @mood_word = ["urgent", "angry", "important", "mcdonalds", "emergency", "danger"].sample
  elsif @my_color == "yellow"
    @mood_word = ["easy", "happy", "golden", "banana", "minion", "star"].sample
  elsif @my_color == "green"
    @mood_word = ["envious", "grow", "money", "nature", "tree", "go"].sample
  else
    @mood_word = "confused"
  end
  erb(:colors)
end

post("/color") do
  # pp params.fetch("my_color")
  binding.irb

  pp params

   @my_color = params['my_color'].downcase
  if @my_color == "blue"
    @mood_word = ["sad", "glad", "blue", "sky", "sea", "calm"].sample
  elsif @my_color == "red"
    @mood_word = ["urgent", "angry", "important", "mcdonalds", "emergency", "danger"].sample
  elsif @my_color == "yellow"
    @mood_word = ["easy", "happy", "golden", "banana", "minion", "star"].sample
  elsif @my_color == "green"
    @mood_word = ["envious", "grow", "money", "nature", "tree", "go"].sample
  else
    @mood_word = "I'm confused"
  end
  erb(:colors)
end
