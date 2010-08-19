require 'net/http'
require 'json'
require 'uri'

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
    
    protected
    def get_json_response(url)
      transform_json_response(JSON.parse(Net::HTTP.get_response(URI.parse(url)).body))
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
    
    def transform_json_response(response)    
      if response.class == Hash
        r = Hash.new
        response.keys.each do |k|
          r[k.to_sym] = transform_json_response(response[k])
        end
        return r
      elsif response.class == Array and response.size == 1  
        return transform_json_response(response[0])
      else
        return response
      end
    end
  end
end