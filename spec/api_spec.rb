require File.dirname(__FILE__) + '/spec_helper'

module Rebay
  describe Api do
    it "should respond to configure" do
      Rebay::Api.should respond_to(:configure)
    end
    
    it "should allow setting of app_id" do
      Rebay::Api.should respond_to(:app_id=)
    end
    
    it "should allow getting of app_id" do
      Rebay::Api.should respond_to(:app_id)
    end
    
    it "should return app id after configureation" do
      Rebay::Api.configure do |rebay|
        rebay.app_id = 'test'
      end
      Rebay::Api.app_id.should == 'test'
    end
    
    it "should build rest payload from has" do
      api = Rebay::Api.new
      api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah'}).should eq("&test=blah&test2=blah&test3=blah")
    end
  end
end