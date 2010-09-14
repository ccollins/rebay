require 'rebay/api'
require 'rebay/finding'
require 'rebay/shopping'
require 'rebay/response'

module Rebay
  require 'rebay/railtie' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end