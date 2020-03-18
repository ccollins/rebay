require File.dirname(__FILE__) + "/spec_helper"

module Rebay
  describe Response do
    context "on creation" do
      it "should transform the happy json" do
        json_happy = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/get_search_keywords_recommendation_happy"))
        response = Response.new(json_happy)
        response.response.should eq({"getSearchKeywordsRecommendationResponse" => {"ack" => "Success", "version" => "1.5.0", 
                                                                                  "timestamp" => "2010-08-13T21:11:02.539Z", "keywords" => "accordion"}})
      end
      
      it "should transform the sad json" do
        json_sad = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/get_search_keywords_recommendation_sad"))
        response = Response.new(json_sad)
        response.response.should eq({"getSearchKeywordsRecommendationResponse" =>
                        {"ack" => "Warning",
                         "errorMessage" => {"error" => {"errorId" => "59", "domain" => "Marketplace", "severity" => "Warning",
                                                      "category" => "Request", "message" => "No recommendation was identified for the submitted keywords.",
                                                      "subdomain" => "Search"}},
                         "version" => "1.5.0",
                         "timestamp" => "2010-08-13T21:08:30.081Z",
                         "keywords" => ""}})
      end
    end
    
    it "should return success" do
      response = Response.new({"Ack" => "Success"})
      response.success?.should be_true
      response.failure?.should be_false
    end
  
    it "should return failure" do
      response = Response.new({"Ack" => "Failure"})
      response.failure?.should be_true
      response.success?.should be_false
    end
  
    it "should trim response" do
      response = Response.new({"Ack" => "Failure", "test" => "test"})
      response.trim("test")
      response.response.should eq("test")
    end
    
    it "should trim response with syn" do
      response = Response.new({"Ack" => "Failure", "test" => "test"})
      response.trim(:test)
      response.response.should eq("test")
    end
  
    it "should not trim response" do
      response = Response.new({"Ack" => "Failure", "test" => "test"})
      response.trim(:nothing)
      response.response.should eq({"Ack" => "Failure", "test" => "test"})
    end
    
    it "should set result key" do
      response = Response.new({})
      response.should respond_to(:results)
    end
    
    it "should provide empty iterator without a result key" do
      response = Response.new({})
      count = 0
      response.each { |r| count = count + 1 }
      count.should eq(0)
    end
    
    context "using find items advanced json" do
      before(:each) do
        @json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/find_items_advanced"))
        @response = Response.new(@json)
        @response.trim(:findItemsAdvancedResponse)
        @proper = {"ack"=>"Success", "version"=>"1.7.0", "timestamp"=>"2010-09-29T01:53:58.039Z",
                   "searchResult"=>{"@count"=>"2",
                     "item"=>[{"itemId"=>"300471157219","title"=>"Minas Tirith 1990 Tolkien fanzine journal LOTR Hobbit",
                              "globalId"=>"EBAY-US","primaryCategory"=>{"categoryId"=>"280","categoryName"=>"Magazine Back Issues"},
                              "secondaryCategory"=>{"categoryId"=>"29799","categoryName"=>"Other"},
                              "galleryURL"=>"https:\/\/thumbs4.ebaystatic.com\/pict\/3004711572198080_1.jpg",
                              "viewItemURL"=>"https:\/\/cgi.ebay.com\/Minas-Tirith-1990-Tolkien-fanzine-journal-LOTR-Hobbit-\/300471157219?pt=Magazines",
                              "paymentMethod"=>"PayPal","autoPay"=>"false","postalCode"=>"55403","location"=>"Minneapolis,MN,USA",
                              "country"=>"US","shippingInfo"=>{"shippingServiceCost"=>{"@currencyId"=>"USD","__value__"=>"2.99"},
                                                               "shippingType"=>"Flat","shipToLocations"=>"Worldwide"},
                              "sellingStatus"=>{"currentPrice"=>{"@currencyId"=>"USD","__value__"=>"16.99"},
                                                "convertedCurrentPrice"=>{"@currencyId"=>"USD","__value__"=>"16.99"},
                                                "bidCount"=>"1","sellingState"=>"Active","timeLeft"=>"P0DT0H3M56S"},
                              "listingInfo"=>{"bestOfferEnabled"=>"false","buyItNowAvailable"=>"false",
                                              "startTime"=>"2010-09-22T01:57:54.000Z","endTime"=>"2010-09-29T01:57:54.000Z",
                                              "listingType"=>"Auction","gift"=>"false"},
                              "condition"=>{"conditionId"=>"4000","conditionDisplayName"=>"Very Good"}},
                              {"itemId"=>"300471157219","title"=>"Minas Tirith 1990 Tolkien fanzine journal LOTR Hobbit",
                              "globalId"=>"EBAY-US","primaryCategory"=>{"categoryId"=>"280","categoryName"=>"Magazine Back Issues"},
                              "secondaryCategory"=>{"categoryId"=>"29799","categoryName"=>"Other"},
                              "galleryURL"=>"https:\/\/thumbs4.ebaystatic.com\/pict\/3004711572198080_1.jpg",
                              "viewItemURL"=>"https:\/\/cgi.ebay.com\/Minas-Tirith-1990-Tolkien-fanzine-journal-LOTR-Hobbit-\/300471157219?pt=Magazines",
                              "paymentMethod"=>"PayPal","autoPay"=>"false","postalCode"=>"55403","location"=>"Minneapolis,MN,USA",
                              "country"=>"US","shippingInfo"=>{"shippingServiceCost"=>{"@currencyId"=>"USD","__value__"=>"2.99"},
                                                               "shippingType"=>"Flat","shipToLocations"=>"Worldwide"},
                              "sellingStatus"=>{"currentPrice"=>{"@currencyId"=>"USD","__value__"=>"16.99"},
                                                "convertedCurrentPrice"=>{"@currencyId"=>"USD","__value__"=>"16.99"},
                                                "bidCount"=>"1","sellingState"=>"Active","timeLeft"=>"P0DT0H3M56S"},
                              "listingInfo"=>{"bestOfferEnabled"=>"false","buyItNowAvailable"=>"false",
                                              "startTime"=>"2010-09-22T01:57:54.000Z","endTime"=>"2010-09-29T01:57:54.000Z",
                                              "listingType"=>"Auction","gift"=>"false"},
                              "condition"=>{"conditionId"=>"4000","conditionDisplayName"=>"Very Good"}}]},
                   "paginationOutput"=>{"pageNumber"=>"1","entriesPerPage"=>"2","totalPages"=>"2359","totalEntries"=>"4717"},
                   "itemSearchURL"=>"https:\/\/shop.ebay.com\/i.html?_nkw=tolkien&_ddo=1&_ipg=2&_pgn=1"}
        @response.results = @response.response['searchResult']['item']
      end
      
      it "should trim format response correctly" do
        @response.response.should eq(@proper)
      end
      
      it "should show correct size" do
        @response.size.should eq(2)
      end
    end
  end
end