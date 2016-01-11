source 'https://rubygems.org'

ruby '2.2.3' # EDGE as is

gem 'rails', '4.2.4'

gem 'responders'

gem 'sprockets', '2.12.3' # gem 'angular-rails-templates' conflicts with newer versions :(

gem 'slim'
gem 'coffee-rails'
gem 'sass-rails'
gem 'bourbon'
gem 'bootstrap-sass'
gem 'bh' # Bootstrap Helpers

gem 'jquery-rails'
gem 'angularjs-rails', git: 'https://github.com/ScoutRFP/angularjs-rails' # <- Better fork
gem 'angular-rails-templates'
gem 'angular_rails_csrf'

gem 'uglifier'
gem 'jbuilder'
gem 'forgery'

gem 'genealogy'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'bullet'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production do
  gem 'pg'

  gem 'rails_12factor'
  gem 'puma'
end

