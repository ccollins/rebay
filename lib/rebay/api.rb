require 'net/http'
require 'json'
require 'uri'

class String
  #http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-camelize
  def camelize(first_letter_in_uppercase = false)
    if first_letter_in_uppercase
      self.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      self[0].chr.downcase + camelize(self)[1..-1]
    end
  end
end

module Rebay
  class Api
    EBAY_US = 0
  
    def self.app_id= app_id
      @@app_id = app_id
    end
    
    def self.app_id
      @@app_id
    end
      
    def self.configure
      yield self if block_given?
    end
    
    def self.has_rebay_finder(*finders)
      finders.each do |finder|
        define_method "#{finder}" do |*params|
          api_call = finder.to_s.camelize
          api_params = params || {}
          response = get_json_response(build_request_url(api_call, api_params))
          response.trim("#{api_call}Response")
      
          if response.response.has_key?('searchResult') && response.response['searchResult'].has_key?('item')
            response.results = response.response['searchResult']['item']
          elsif response.response.has_key?('keywords')
            response.results = response.response['keywords']
          elsif response.response.has_key?('version')
            response.results = response.response['version']
          end
          return response
        end
      end
    end

    protected
    def get_json_response(url)
      Rebay::Response.new(JSON.parse(Net::HTTP.get_response(URI.parse(url)).body))
    end
    
    def build_rest_payload(params={})
      params.reduce('') { |memo, obj| memo += URI.escape "&#{obj[0]}=#{obj[1]}" }
    end
  end
end