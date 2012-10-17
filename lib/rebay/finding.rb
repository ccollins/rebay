module Rebay
  class Finding < Rebay::Api
    BASE_URL_PREFIX = 'http://svcs'
    BASE_URL_SUFFIX = 'ebay.com/services/search/FindingService/v1'
    VERSION = '1.0.0'
    
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsAdvanced.html
    def find_items_advanced(params)
      raise ArgumentError unless params[:keywords] or params[:categoryId]
      response = get_json_response(build_request_url('findItemsAdvanced', params))
      response.trim(:findItemsAdvancedResponse)
      
      if response.response.has_key?('searchResult') && response.response['searchResult'].has_key?('item')
        response.results = response.response['searchResult']['item']
      end
      return response
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByCategory.html
    def find_items_by_category(params)
      raise ArgumentError unless params[:categoryId]
      response = get_json_response(build_request_url('findItemsByCategory', params))
      response.trim(:findItemsByCategoryResponse)
      if response.response.has_key?('searchResult') && response.response['searchResult'].has_key?('item')
        response.results = response.response['searchResult']['item']
      end
      return response
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByKeywords.html
    def find_items_by_keywords(params)
      raise ArgumentError unless params[:keywords]
      response = get_json_response(build_request_url('findItemsByKeywords', params))
      response.trim(:findItemsByKeywordsResponse)
      if response.response.has_key?('searchResult') && response.response['searchResult'].has_key?('item')
        response.results = response.response['searchResult']['item']
      end
      return response
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByProduct.html
    def find_items_by_product(params)
      raise ArgumentError unless params[:productId]
      params['productId.@type'] = 'ReferenceID'
      response = get_json_response(build_request_url('findItemsByProduct', params))
      response.trim(:findItemsByProductResponse)
      if response.response.has_key?('searchResult') && response.response['searchResult'].has_key?('item')
        response.results = response.response['searchResult']['item']
      end
      return response
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsIneBayStores.html
    def find_items_in_ebay_stores(params)
      raise ArgumentError unless params[:keywords] or params[:storeName]
      response = get_json_response(build_request_url('findItemsIneBayStores', params))
      response.trim(:findItemsIneBayStoresResponse)
      if response.response.has_key?('searchResult') && response.response['searchResult'].has_key?('item')
        response.results = response.response['searchResult']['item']
      end
      return response
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getHistograms.html
    def get_histograms(params)
      raise ArgumentError unless params[:categoryId]
      response = get_json_response(build_request_url('getHistograms', params))
      response.trim(:getHistorgramsResponse)
      return response
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getSearchKeywordsRecommendation.html
    def get_search_keywords_recommendation(params)
      raise ArgumentError unless params[:keywords]
      response = get_json_response(build_request_url('getSearchKeywordsRecommendation', params))
      response.trim(:getSearchKeywordsRecommendationResponse)
      if response.response.has_key?('keywords')
        response.results = response.response['keywords']
      end
      return response
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getVersion.html
    def get_version
      response = get_json_response(build_request_url('getVersion'))
      response.trim(:getVersionResponse)
      if response.response.has_key?('version')
        response.results = response.response['version']
      end
      return response
    end
    
    private    
    def build_request_url(service, params=nil)
      url = "#{self.class.base_url}?OPERATION-NAME=#{service}&SERVICE-VERSION=#{VERSION}&SECURITY-APPNAME=#{Rebay::Api.app_id}&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD"
      url += build_rest_payload(params)
      return url
    end
  end
end
