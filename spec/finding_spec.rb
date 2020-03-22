require File.dirname(__FILE__) + '/spec_helper'

module Rebay
  describe Finding do
    before(:each) do
        @finder = Finding.new
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new({"Ack" => 'Success'}))
    end

    it "should specify base url" do
      Finding.base_url.should_not be_nil
    end
    
    it "should specify version" do
      Finding::VERSION.should_not be_nil
    end
    
    context "after creation" do
      it "should provide find_completed_items" do
        @finder.should respond_to(:find_completed_items)
      end
      it "should provide find_items_advanced" do
        @finder.should respond_to(:find_items_advanced)
      end
      
      it "should provide find_items_by_category" do
        @finder.should respond_to(:find_items_by_category)
      end
      
      it "should provide find_items_by_product" do
        @finder.should respond_to(:find_items_by_product)
      end
      
      it "should provide find_items_in_ebay_stores" do
        @finder.should respond_to(:find_items_in_ebay_stores)
      end
      
      it "should provide get_histograms" do
        @finder.should respond_to(:get_histograms)
      end
      
      it "should provide get_search_keywords_recommendation" do
        @finder.should respond_to(:get_search_keywords_recommendation)
      end
      
      it "should provide get_version" do
        @finder.should respond_to(:get_version)
      end
    end

    context "when calling find_completed_items" do
      it "should fail without args" do
        lambda { @finder.find_completed_items }.should raise_error(ArgumentError)
      end

      it "should return a hash response for a category id" do
        @finder.find_completed_items({:categoryId => 1}).class.should eq(Rebay::Response)
      end

      it "should return a hash response for keywords" do
        @finder.find_completed_items({:keywords => 'feist'}).class.should eq(Rebay::Response)
      end

      it "should succeed with a category id" do
        @finder.find_completed_items({:categoryId => 1}).success?.should be_true
      end

      it "should succeed with a keyword" do
        @finder.find_completed_items({:keywords => 'feist'}).success?.should be_true
      end

      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/find_completed_items"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.find_completed_items({:categoryId => 1})

        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(2)
      end
    end

    context "when calling find_items_advanced" do     
      it "should fail without args" do
        lambda { @finder.find_items_advanced }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response with categoryId as parameter" do
        @finder.find_items_advanced({:categoryId => 1}).class.should eq(Rebay::Response)
      end
      
      it "should return a hash response with keywords as parameter" do
        @finder.find_items_advanced({:keywords => 'feist'}).class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.find_items_advanced({:keywords => 'feist'}).success?.should be_true
      end
      
      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/find_items_advanced"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.find_items_advanced({:keywords => 'whatevs'})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(2)
      end
      
      it "should work with 1 result" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/find_items_advanced_one_item"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.find_items_advanced({:categoryId => 1})
        count = 0

        response.each { |r| count = count + 1 }
        count.should eq(1)
      end
    end
    
    context "when calling find_items_by_category" do     
      it "should fail without args" do
        lambda { @finder.get_search_keywords_recommendation }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.find_items_by_category({:categoryId => 1}).class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.find_items_by_category({:categoryId => 1}).success?.should be_true
      end
      
      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/find_items_by_category"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.find_items_by_category({:categoryId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(2)
      end
    end
    
    context "when calling find_items_by_product" do    
      it "should fail without args" do
        lambda { @finder.find_items_by_product }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.find_items_by_product({:productId => 53039031}).class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.find_items_by_product({:productId => 53039031}).success?.should be_true
      end
      
      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/find_items_by_product"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.find_items_by_product({:productId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(2)
      end
    end
  
    context "when calling find_items_by_keywords" do     
      it "should fail without args" do
        lambda { @finder.find_items_by_keywords }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.find_items_by_keywords({:keywords => 'feist'}).class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.find_items_by_keywords({:keywords => 'feist'}).success?.should be_true
      end
      
      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/find_items_by_keywords"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.find_items_by_keywords({:keywords => 'whatevs'})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(2)
      end
    end
    
    context "when calling find_items_in_ebay_stores" do
      it "should fail without args" do
        lambda { @finder.find_items_in_ebay_stores }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response with storeName as parameter" do
        @finder.find_items_in_ebay_stores({:storeName => 'Laura_Chen\'s_Small_Store'}).class.should eq(Rebay::Response)
      end
      
      it "should return a hash response with keywords as parameter" do
        @finder.find_items_in_ebay_stores({:keywords => 'feist'}).class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.find_items_in_ebay_stores({:keywords => 'feist'}).success?.should be_true
      end
    end
    
    context "when calling get_histograms" do
      it "should fail without args" do
        lambda { @finder.get_histograms }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.get_histograms({:categoryId => 1}).class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.get_histograms({:categoryId => 1}).success?.should be_true
      end
    end
    
    context "when calling get_search_keywords_recommendation" do
      it "should fail without args" do
        lambda { @finder.get_search_keywords_recommendation }.should raise_error(ArgumentError)
      end
      
      it "should return a hash response" do
        @finder.get_search_keywords_recommendation({:keywords => 'feist'}).class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.get_search_keywords_recommendation({:keywords => 'feist'}).success?.should be_true
      end
      
      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/get_search_keywords_recommendation"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.get_search_keywords_recommendation({:keywords => 'whatevs'})
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(1)
        
        response.results.should eq('harry potter phoenix')
      end
    end
    
    context "when calling get_version" do
      it "should return a hash response" do
        @finder.get_version.class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.get_version.success?.should be_true
      end
      
      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/finding/get_version"))
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new(json))
        response = @finder.get_version
        
        count = 0
        response.each { |r| count = count + 1 }
        count.should eq(1)
        
        response.results.should eq('1.8.0')
      end
    end
  end
end
