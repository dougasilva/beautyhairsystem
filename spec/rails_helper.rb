require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails
    .env.production?

require 'capybara/dsl'
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'
require 'pry'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.backtrace_exclusion_patterns << /gems/
  config.example_status_persistence_file_path = "examples.txt"
  Capybara.default_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist

  # DatabaseCleaner
  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, :js => true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end
