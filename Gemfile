source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use SCSS for stylesheets
gem 'sass-rails', '4.0.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
# gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "pg"
# Backend admin login & auth
gem 'devise'

group :development, :test do
  gem "pry"
  gem 'dotenv-rails'
end

group :test do
  gem "rack_session_access"
  gem "rspec-rails"
  gem 'faker'
  gem "guard-rspec"
  gem 'mocha'
  gem 'shoulda'
  gem 'terminal-notifier-guard'
  gem "capybara"
  gem "selenium-webdriver"
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem 'simplecov', :require => false
  # gem "codeclimate-test-reporter", :require => nil
  gem 'launchy'
  # gem 'stripe-ruby-mock'
  gem 'bourne', :github => "flatiron-labs/bourne"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'annotate', github: 'ctran/annotate_models'
  # gem "better_errors"
  gem "quiet_assets"
  # gem "binding_of_caller"
  # gem "sprockets_better_errors"
  gem 'puma'
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  gem 'railroady'
end

group :production do
  gem "google-analytics-rails"
  gem "rails_12factor"
end

gem "bootstrap-sass", "~> 3.1.1"
gem "airbrake"
gem 'bootstrap_form'
gem 'pickadate-rails'
gem 'nokogiri'
gem 'will_paginate'
gem 'websocket-rails'