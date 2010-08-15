module Rebay
  class Api
    @@app_id = ''
  
    def self.app_id= app_id
      @@app_id = app_id
    end
    
    def self.app_id
      return @@app_id
    end
      
    def self.configure
      yield self if block_given?
    end
  end
end