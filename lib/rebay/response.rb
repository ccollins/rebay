module Rebay
  class Response
    attr_accessor :response
    attr_accessor :result_key
    
    def initialize(json_response)
      print "INITIAL TRANSFORM ********\n\n\n\n"
      @response = transform_json_response(json_response)
    end
    
    def success?
      return @response["Ack"] == 'Success'
    end
    
    def failure?
      return @response["Ack"] == 'Failure'
    end
    
    def trim(key)
      if @response.has_key?(key.to_s)
        @response = @response[key.to_s]
      end
    end
    
    protected
    def transform_json_response(response)    
      if response.class == Hash
        r = Hash.new
        response.keys.each do |k|
          r[k] = transform_json_response(response[k])
        end
        return r
      elsif response.class == Array 
        if response.size == 1  
          return transform_json_response(response[0])
        else
          r = Array.new
          response.each do |a|
            r.push(transform_json_response(a))
          end
          return r
        end
      else
        return response
      end
    end
  end
end