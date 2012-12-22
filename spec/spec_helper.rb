require 'bundler/setup'
require File.join(File.dirname(__FILE__), "..", "lib", "rebay")

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end

Rebay::Api.configure do |rebay|
  rebay.app_id = 'default'
end
