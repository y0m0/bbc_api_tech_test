ENV['RACK_ENV'] = 'test'

require_relative '../lib/layout_configurator'
require 'rack/test'
require 'simplecov'
require 'simplecov-console'
require 'database_cleaner'

SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

RSpec.configure do |config|
  config.include Rack::Test::Methods

  ## Database Cleaner
  # this is run one time before running all the tests
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # this is run one time before each single test
  config.before(:each) do
    DatabaseCleaner.start
  end

  # this is run one time after each test
  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def app
  LayoutConfigurator::Api
end
