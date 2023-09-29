ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!
unless ENV["MINITEST_REPORTER"]
  Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  include FactoryBot::Syntax::Methods

  # Used inside a test to indicate we haven't implemented it yet
  def not_implemented!
    skip("not implemented yet")
  end
end
