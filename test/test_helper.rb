ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/mock'
require 'capybara/rails'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# add support folder
Dir[Rails.root.join("test/support/**/*")].each { |f| require f }

Capybara.ignore_hidden_elements = true

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
