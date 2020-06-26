source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails'

gem 'bootsnap'
gem 'bootstrap-sass'
gem 'cocoon'
gem 'jbuilder'
gem 'jquery-rails'
gem 'paranoia'
gem 'pry-byebug'
gem 'responders'
gem 'sdoc', group: :doc
gem 'seed_dump'
gem 'simple_form'
gem 'sqlite3', '1.3.13'
gem 'turbolinks'
gem 'watu_table_builder', require: 'table_builder'

group :assets do
  gem 'bcrypt'
  gem 'coffee-rails'
  gem 'compass-rails'
  gem 'sass-rails'
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'puma'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem 'rspec', github: 'rspec/rspec'
  gem 'rspec-core', github: 'rspec/rspec-core'
  gem 'rspec-mocks', github: 'rspec/rspec-mocks'
  gem 'rspec-expectations', github: 'rspec/rspec-expectations'
  gem 'rspec-support', github: 'rspec/rspec-support'
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'simplecov'
  gem 'arel-helpers'
  gem 'webdrivers', '~> 4.0'
end

group :development do
  gem 'spring'
  gem 'web-console'
end
