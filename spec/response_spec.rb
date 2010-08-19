require File.dirname(__FILE__) + '/spec_helper'

module Rebay
  describe Response do
    context "on creation" do
      it "should transform the happy json" do
        json_happy = JSON.parse(File.read(File.dirname(__FILE__) + '/json_responses/finding/get_search_keywords_recommendation_happy.json'))
        response = Response.new(json_happy)
        response.response.should eq({:getSearchKeywordsRecommendationResponse => {:ack => "Success", :version => "1.5.0", 
                                                                                  :timestamp => "2010-08-13T21:11:02.539Z", :keywords => "accordion"}})
      end
      
      it "should transform the sad json" do
        json_sad = JSON.parse(File.read(File.dirname(__FILE__) + '/json_responses/finding/get_search_keywords_recommendation_sad.json'))
        response = Response.new(json_sad)
        response.response.should eq({:getSearchKeywordsRecommendationResponse =>
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