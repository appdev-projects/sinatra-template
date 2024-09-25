require "./config/environment"
set :public_folder, "public"
set :static, true
run(Sinatra::Application)
