require File.dirname(__FILE__) + '/spec_helper'

module Rebay
  describe Api do
    describe Api.base_url_prefix do
      it "shouldn't be nil" do
        Rebay::Api.base_url_prefix.should_not be_nil
      end
    end

    describe Api.base_url_suffix do
      it "shouldn't be nil" do
        Rebay::Api.base_url_suffix.should_not be_nil
      end
    end

    describe "#base_url" do
      context "api calls should hit the sandbox" do
        it "should return a sandboxed url" do
          Rebay::Api.configure do |c|
            c.sandbox = true
          end
          
          Rebay::Api.base_url.should include "sandbox"
        end
      end

      context "api calls shouldn't hit the sandbox" do
        it "should return a un-sandboxed url" do
          Rebay::Api.configure do |c|
            c.sandbox = false
          end

          Rebay::Api.base_url.should_not include "sandbox"
        end
      end
    end
    
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
      app_id = Rebay::Api.app_id
      Rebay::Api.configure do |rebay|
        rebay.app_id = 'test'        
      end
      Rebay::Api.app_id.should == 'test'
      Rebay::Api.configure do |rebay|
        rebay.app_id = app_id
      end
    end
    
    context "when calling build_rest_payload" do
      before(:each) do
        @api = Rebay::Api.new
      end
      
      it "should build rest payload from hash" do
        payload = @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah'})
        payload.should include("&test=blah")
        payload.should include("&test2=blah")
        payload.should include("&test3=blah")
      end
    
      it "should escape html chars" do
         payload = @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah blah'})
         payload.should include("&test=blah")
         payload.should include("&test2=blah")
         payload.should include("&test3=blah%20blah")
      end
    end
  end
end
