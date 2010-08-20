module Rebay
  class Response
    attr_accessor :response
    
    def initialize(json_response)
      @response = transform_json_response(json_response)
    end
    
    def success?
      return @response[:Ack] == 'Success'
    end
    
    def failure?
      return @response[:Ack] == 'Failure'
    end
    
    def trim(key)
      if @response.has_key?(key)
        @response = @response[key]
      end
    end
    
    protected
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