require File.dirname(__FILE__) + '/spec_helper'

module Rebay
  describe Finding do
    before(:each) do
        @finder = Finding.new
        @finder.stub!(:get_json_response).and_return(Rebay::Response.new({"Ack" => 'Success'}))
    end
      
    it "should specify base url" do
      Finding::BASE_URL.should_not be_nil
    end
    
    it "should specify version" do
      Finding::VERSION.should_not be_nil
    end
    
    context "after creation" do
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
    end
    
    context "when calling get_version" do
      it "should return a hash response" do
        @finder.get_version.class.should eq(Rebay::Response)
      end
      
      it "should succeed" do
        @finder.get_version.success?.should be_true
      end
    end
  end
end
