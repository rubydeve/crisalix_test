require 'capybara/rspec'
require 'capybara/rails'

Capybara.configure do |config|
  config.default_driver = :rack_test # Use Rack::Test for headless testing
  # You can also configure Capybara to use Selenium WebDriver for browser testing:
  # config.default_driver = :selenium_chrome
  # config.app_host = 'http://localhost:3000' # Set the app host for full URLs
end

RSpec.configure do |config|
  config.include Capybara::DSL
  # other RSpec configuration...
end
