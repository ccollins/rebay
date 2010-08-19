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
        @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah'}).should eq("&test=blah&test2=blah&test3=blah")
      end
    
      it "should escape html chars" do
        @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah blah'}).should eq("&test=blah&test2=blah&test3=blah%20blah")
      end
    end
    
    context "when parsing response" do
      before(:each)  do
        @json_happy = JSON.parse(File.read(File.dirname(__FILE__) + '/json_responses/finding/get_search_keywords_recommendation_happy.json'))
        @json_sad = JSON.parse(File.read(File.dirname(__FILE__) + '/json_responses/finding/get_search_keywords_recommendation_sad.json'))
        @api = Api.new
      end
      
      it "should transform the happy json" do
        happy = @api.send :transform_json_response, @json_happy
        happy.should eq({:getSearchKeywordsRecommendationResponse => {:ack => "Success", :version => "1.5.0", 
                                                                      :timestamp => "2010-08-13T21:11:02.539Z", :keywords => "accordion"}})
      end
      
      it "should transform the sad json" do
        sad = @api.send :transform_json_response, @json_sad
        sad.should eq({:getSearchKeywordsRecommendationResponse =>
                        {:ack => "Warning",
                         :errorMessage => {:error => {:errorId => "59", :domain => "Marketplace", :severity => "Warning",
                                                      :category => "Request", :message => "No recommendation was identified for the submitted keywords.",
                                                      :subdomain => "Search"}},
                         :version => "1.5.0",
                         :timestamp => "2010-08-13T21:08:30.081Z",
                         :keywords => ""}})
      end
    end
  end
end