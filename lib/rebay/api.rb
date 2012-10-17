require 'net/http'
require 'json'
require 'uri'

module Rebay
  class Api
    EBAY_US = 0

    BASE_URL_PREFIX = "http://svcs"
    BASE_URL_SUFFIX = "ebay.com"

    def self.base_url
      [BASE_URL_PREFIX,
       sandbox ? "sandbox" : nil,
       BASE_URL_SUFFIX].compact.join('.')
    end
    
    def self.app_id= app_id
      @@app_id = app_id
    end
    
    def self.app_id
      @@app_id
    end

    def self.sandbox= sandbox
      @@sandbox = sandbox
    end

    def self.sandbox
      @@sandbox ||= false
    end
      
    def self.configure
      yield self if block_given?
    end
    
    protected
    def get_json_response(url)
      Rebay::Response.new(JSON.parse(Net::HTTP.get_response(URI.parse(url)).body))
    end
    
    def build_rest_payload(params)
      payload = ''
      unless params.nil?
        params.keys.each do |key|
          payload += URI.escape "&#{key}=#{params[key]}"
        end
      end
      return payload
    end
  end
end
