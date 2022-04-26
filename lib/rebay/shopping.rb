module Rebay
  class Shopping < Rebay::Api
    attr_accessor :token

    VERSION = '1199'

    class << self
      def base_url_prefix
        "http://open.api"
      end

      def base_url_suffix
        "ebay.com/shopping"
      end
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindProducts.html
    def find_products(params)
      raise ArgumentError unless params[:CategoryID] or params[:ProductID] or params[:QueryKeywords] or
        (params[:'ProductID.Value'] && params[:'ProductID.type'])
      response = get_json_response(build_request_url('FindProducts', params), headers: headers)
      if response.response.has_key?('Product')
        response.results = response.response['Product']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindHalfProducts.html
    def find_half_products(params)
      raise ArgumentError unless params[:ProductID] or params[:QueryKeywords] or
        (params[:'ProductID.Value'] && params[:'ProductID.type'])
      response = get_json_response(build_request_url('FindHalfProducts', params), headers: headers)
      if response.response.has_key?('Products') && response.response['Products'].has_key?('Product')
        response.results = response.response['Products']['Product']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetSingleItem.html
    def get_single_item(params)
      raise ArgumentError unless params[:ItemID]
      response = get_json_response(build_request_url('GetSingleItem', params), headers: headers)
      if response.response.has_key?('Item')
        response.results = response.response['Item']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetItemStatus.html
    def get_item_status(params)
      raise ArgumentError unless params[:ItemID]
      response = get_json_response(build_request_url('GetItemStatus', params), headers: headers)
      if response.response.has_key?('Item')
        response.results = response.response['Item']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetShippingCosts.html
    def get_shipping_costs(params)
      raise ArgumentError unless params[:ItemID]
      response = get_json_response(build_request_url('GetShippingCosts', params), headers: headers)
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetMultipleItems.html
    def get_multiple_items(params)
      raise ArgumentError unless params[:ItemID]
      response = get_json_response(build_request_url('GetMultipleItems', params), headers: headers)
      if response.response.has_key?('Item')
        response.results = response.response['Item']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetUserProfile.html
    def get_user_profile(params)
      raise ArgumentError unless params[:UserID]
      response = get_json_response(build_request_url('GetUserProfile', params), headers: headers)
      if response.response.has_key?('User')
        response.results = response.response['User']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindPopularSearches.html
    def find_popular_searches(params)
      raise ArgumentError unless params[:CategoryID]
      response = get_json_response(build_request_url('FindPopularSearches', params), headers: headers)
      if response.response.has_key?('PopularSearchResult')
        response.results = response.response['PopularSearchResult']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindPopularItems.html
    def find_popular_items(params={})
      raise ArgumentError unless params[:CategoryID] or params[:QueryKeywords]
      response = get_json_response(build_request_url('FindPopularItems', params), headers: headers)
      if response.response.has_key?('ItemArray') && response.response['ItemArray'].has_key?('Item')
        response.results = response.response['ItemArray']['Item']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/FindReviewsandGuides.html
    def find_reviews_and_guides(params={})
      response = get_json_response(build_request_url('FindReviewsAndGuides', params), headers: headers)
      if response.response.has_key?('BuyingGuideDetails') && response.response['BuyingGuideDetails'].has_key?('BuyingGuide')
        response.results = response.response['BuyingGuideDetails']['BuyingGuide']
      end
      return response
    end

    #http://developer.ebay.com/DevZone/shopping/docs/CallRef/GetCategoryInfo.html
    def get_category_info(params)
      raise ArgumentError unless params[:CategoryID]
      response = get_json_response(build_request_url('GetCategoryInfo', params), headers: headers)
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
      app_id = params.key?(:app_id) && params.delete(:app_id)
      url = "#{self.class.base_url}?callname=#{service}&appid=#{app_id || Rebay::Api.app_id}&X-EBAY-SOA-GLOBAL-ID=#{Rebay::Api.default_site_id}&version=#{VERSION}&responseencoding=JSON"
      url += build_rest_payload({siteid: Rebay::Api.default_site_id}.merge(params))
      return url
    end

    def headers
      {
        'X-EBAY-API-IAF-TOKEN' => self.token,
      }
    end
  end
end
