require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:home_page)
end

get("/red") do
  mood_words = ["urgent", "angry", "important", "mcdonalds", "emergency", "danger"]
  @mood_word = mood_words.sample
  erb(:red)
end

get("/yellow") do
  mood_words = ["easy", "happy", "golden", "banana", "minion", "star"]
  @mood_word = mood_words.sample
  erb(:yellow)
end

get("/blue") do
  mood_words = ["sad", "glad", "blue", "sky", "sea", "calm"]
  @mood_word = mood_words.sample
  erb(:blue)
end
