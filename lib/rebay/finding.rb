module Rebay
  class Finding < Rebay::Api
    BASE_URL = 'http://svcs.ebay.com/services/search/FindingService/v1'
    VERSION = '1.0.0'

    has_rebay_finder :find_items_advanced, :find_items_by_category, :find_items_by_keywords, :find_items_by_product,
                     :find_items_ine_bay_stores, :get_histograms, :get_search_keywords_recommendation,
                     :get_version
    alias :find_items_in_ebay_stores :find_items_ine_bay_stores
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsAdvanced.html
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByCategory.html
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByKeywords.html  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByProduct.html
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsIneBayStores.html
    #http://developer.ebay.com/DevZone/finding/CallRef/getHistograms.html
    #http://developer.ebay.com/DevZone/finding/CallRef/getSearchKeywordsRecommendation.html
    #http://developer.ebay.com/DevZone/finding/CallRef/getVersion.html

    private    
    def build_request_url(service, params={})
      url = "#{BASE_URL}?OPERATION-NAME=#{service}&SERVICE-VERSION=#{VERSION}&SECURITY-APPNAME=#{Rebay::Api.app_id}&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD"
      url += build_rest_payload(params)
      return url
    end
  end
end