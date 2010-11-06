module Rebay
  class Response
    attr_accessor :response
    attr_accessor :results
    
    def initialize(json_response)
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
    
    def each
      unless @results.nil?
        if @results.class == Array
          @results.each { |r| yield r }
        else
          yield @results
        end
      end
    end
    
    def size
      if @results.nil?
        return 0
      elsif @results.class == Array
        return @results.size
      else
        return 1
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