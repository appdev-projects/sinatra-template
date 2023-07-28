source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "sinatra"
gem "sinatra-contrib"

gem 'dotenv', '~> 2.8', '>= 2.8.1'
gem 'geocoder', '~> 1.3', '>= 1.3.7'
gem 'httparty', '~> 0.13.7'
# Use Puma as the app server
gem "puma", "~> 5.0"

# use active record
gem "sinatra-activerecord"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "table_print"
  gem "appdev_support"
end

group :development, :test do
  gem "grade_runner"
  gem "pry"
  gem "sqlite3", "~> 1.4"
end

group :test do
  gem "capybara"
  gem "draft_matchers"
  gem "rspec"
  gem "rspec-html-matchers"
  gem "webmock"
  gem "webdrivers"
  gem "i18n"
end
