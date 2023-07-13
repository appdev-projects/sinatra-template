# first we import sinatra so we have access to its 
# objects and methods
require 'sinatra'
require "sinatra/reloader"

# require active record to make use of it
require 'sinatra/activerecord'

get('/') do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end
