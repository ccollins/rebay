module Rebay
  class Shopping < Rebay::Api
    def self.base_url_prefix
      "http://open.api"
    end
    
    def self.base_url_suffix
      "ebay.com/shopping"
    end
    
    VERSION = '793'
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindProducts.html
    def find_products(params)
      raise ArgumentError unless params[:categoryId] or params["ProductID.Value"] or params[:productId] or params[:queryKeywords]
      response = get_json_response(build_request_url('FindProducts', params))
      if response.response.has_key?('Product')
        response.results = response.response['Product']
      end
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindHalfProducts.html
    def find_half_products(params)
      raise ArgumentError unless params["ProductID.Value"] or params[:productId] or params[:queryKeywords]
      response = get_json_response(build_request_url('FindHalfProducts', params))
      if response.response.has_key?('Products') && response.response['Products'].has_key?('Product')
        response.results = response.response['Products']['Product']
      end
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetSingleItem.html
    def get_single_item(params)
      raise ArgumentError unless params[:itemId]
      response = get_json_response(build_request_url('GetSingleItem', params))
      if response.response.has_key?('Item')
        response.results = response.response['Item']
      end
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetItemStatus.html
    def get_item_status(params)
      raise ArgumentError unless params[:itemId]
      response = get_json_response(build_request_url('GetItemStatus', params))
      if response.response.has_key?('Item')
        response.results = response.response['Item']
      end
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetShippingCosts.html
    def get_shipping_costs(params)
      raise ArgumentError unless params[:itemId]
      response = get_json_response(build_request_url('GetShippingCosts', params))
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetMultipleItems.html
    def get_multiple_items(params)
      raise ArgumentError unless params[:itemId]
      response = get_json_response(build_request_url('GetMultipleItems', params))
      if response.response.has_key?('Item')
        response.results = response.response['Item']
      end
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetUserProfile.html
    def get_user_profile(params)
      raise ArgumentError unless params[:userId]
      response = get_json_response(build_request_url('GetUserProfile', params))
      if response.response.has_key?('User')
        response.results = response.response['User']
      end
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindPopularSearches.html
    def find_popular_searches(params)
      raise ArgumentError unless params[:categoryId]
      response = get_json_response(build_request_url('FindPopularSearches', params))
      if response.response.has_key?('PopularSearchResult')
        response.results = response.response['PopularSearchResult']
      end
      return response
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindPopularItems.html
    def find_popular_items(params={})
      raise ArgumentError unless params[:categoryId] or params[:queryKeywords]
      response = get_json_response(build_request_url('FindPopularItems', params))
      if response.response.has_key?('ItemArray') && response.response['ItemArray'].has_key?('Item')
        response.results = response.response['ItemArray']['Item']
      end
      return response
    end
      
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindReviewsandGuides.html
    def find_reviews_and_guides(params={})
      response = get_json_response(build_request_url('FindReviewsAndGuides', params))
      if response.response.has_key?('BuyingGuideDetails') && response.response['BuyingGuideDetails'].has_key?('BuyingGuide')
        response.results = response.response['BuyingGuideDetails']['BuyingGuide']
      end
      return response
    end
   
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetCategoryInfo.html
    def get_category_info(params)
      raise ArgumentError unless params[:categoryId]
      response = get_json_response(build_request_url('GetCategoryInfo', params))
      if response.response.has_key?('CategoryArray') && response.response['CategoryArray'].has_key?('Category')
        response.results = response.response['CategoryArray']['Category']
      end
      return response
    end
    
    def get_category_info_with_children(params)
      params[:IncludeSelector] = 'ChildCategories'
      response = get_category_info(params)
      return response
    end 
    
    private
    def build_request_url(service, params=nil)
      url = "#{self.class.base_url}?callname=#{service}&appid=#{Rebay::Api.app_id}&version=#{VERSION}&responseencoding=JSON&siteid=#{Rebay::Api::EBAY_US}"
      url += build_rest_payload(params)
      return url
    end
  end
end
