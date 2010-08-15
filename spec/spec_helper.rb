require 'rspec'
require File.join(File.dirname(__FILE__), "..", "lib", "rebay")
require 'config'

RSpec.configure do |config|
  config.mock_with :rspec
end

require File.join(File.dirname(__FILE__), '..', 'init.rb')