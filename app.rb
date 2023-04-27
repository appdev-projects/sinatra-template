# first we import sinatra so we have access to its 
# objects and methods
require 'sinatra'

get('/') do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end
