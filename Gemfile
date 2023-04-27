source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'sinatra'
gem 'sinatra-contrib'

# Use Puma as the app server
gem 'puma', '~> 5.0'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'web_git', github: 'firstdraft/web_git'
  gem "grade_runner", github: "firstdraft/grade_runner"
  gem 'pry'
  gem 'sqlite3', '~> 1.4'
end

group :test do
  gem 'capybara'
  gem "draft_matchers", github: "jelaniwoods/draft_matchers", branch: "main"
  gem 'rspec'
  gem 'rspec-html-matchers'
  gem 'webmock'
  gem 'webdrivers'
  gem 'i18n'
end
