require './app'

configure do
  # To open .html.erb files, need to register them
  Tilt.register(Tilt::ERBTemplate, 'html.erb')
  
  # alternative to setting the layout in every erb() call
  # we can set the default layout name to use and sinatra 
  # will look for that file
  set(:erb, :layout => :application_layout)
end

configure :development do
  require "sinatra/reloader"

  # we would also like a nicer error page in development
  require 'better_errors'
  require 'binding_of_caller'
  
  # need this configure for better errors
  use(BetterErrors::Middleware)
  BetterErrors.application_root = __dir__
  BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')

  # appdev support patches
  require "appdev_support"

  AppdevSupport.config do |config|
    # config.action_dispatch = true;
    # config.active_record = true;
    config.pryrc = :full;
    end
  AppdevSupport.init

  # setup a database connection
  set(:database, {adapter: "sqlite3", database: "db/development.sqlite3"})
end
