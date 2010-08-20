module Rebay
  class Shopping < Rebay::Api
    BASE_URL = 'http://open.api.ebay.com/shopping'
    VERSION = '677'
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindProducts.html
    def find_products(params)
      raise ArgumentError unless params[:categoryId] or params[:productId] or params[:queryKeywords]
      get_json_response(build_request_url('FindProducts', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindHalfProducts.html
    def find_half_products(params)
      raise ArgumentError unless params[:productId] or params[:queryKeywords]
      get_json_response(build_request_url('FindHalfProducts', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetSingleItem.html
    def get_single_item(params)
      raise ArgumentError unless params[:itemId]
      get_json_response(build_request_url('GetSingleItem', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetItemStatus.html
    def get_item_status(params)
      raise ArgumentError unless params[:itemId]
      get_json_response(build_request_url('GetItemStatus', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetShippingCosts.html
    def get_shipping_costs(params)
      raise ArgumentError unless params[:itemId]
      get_json_response(build_request_url('GetShippingCosts', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetMultipleItems.html
    def get_multiple_items(params)
      raise ArgumentError unless params[:itemId]
      get_json_response(build_request_url('GetMultipleItems', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetUserProfile.html
    def get_user_profile(params)
      raise ArgumentError unless params[:userId]
      get_json_response(build_request_url('GetUserProfile', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindPopularSearches.html
    def find_popular_searches(params)
      raise ArgumentError unless params[:categoryId]
      get_json_response(build_request_url('FindPopularSearches', params))
    end
    
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindPopularItems.html
    def find_popular_items(params={})
      raise ArgumentError unless params[:categoryId] or params[:queryKeywords]
      get_json_response(build_request_url('FindPopularItems', params))
    end
      
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindReviewsandGuides.html
    def find_reviews_and_guides(params={})
      get_json_response(build_request_url('FindReviewsAndGuides', params))
    end
   
    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetCategoryInfo.html
    def get_category_info(params)
      raise ArgumentError unless params[:categoryId]
      get_json_response(build_request_url('GetCategoryInfo', params))
    end
    
    def get_category_info_with_children(params)
      params[:IncludeSelector] = 'ChildCategories'
      get_category_info(params)
    end 
    
    private
    def build_request_url(service, params=nil)
      url = "#{BASE_URL}?callname=#{service}&appid=#{Rebay::Api.app_id}&version=#{VERSION}&responseencoding=JSON&siteid=#{Rebay::Api::EBAY_US}"
      url += build_rest_payload(params)
      return url
    end
  end
end