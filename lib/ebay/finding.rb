require 'net/http'
require 'json'

module Ebay
  class Finding
    BASE_URL = 'http://svcs.ebay.com/services/search/FindingService/v1'
    
    attr_accessor :app_id
    
    def initialize(app_id)
      @app_id = app_id
    end
    
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsAdvanced.html
    def find_items_advanced(params)
      raise ArgumentError unless params[:keywords] or params[:categoryId]
      get_json_response(build_request_url('findItemsAdvanced', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByCategory.html
    def find_items_by_category(category_id)
      get_json_response(build_request_url('findItemsByCategory', {:categoryId => category_id}))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByKeywords.html
    def find_items_by_keywords(keywords)
      get_json_response(build_request_url('findItemsByKeywords', {:keywords => keywords}))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsByProduct.html
    def find_items_by_product(product_id)
      get_json_response(build_request_url('findItemsByProduct', {'productId.@type' => 'ReferenceID', :productId => product_id}))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/findItemsIneBayStores.html
    def find_items_in_ebay_stores(params)
      raise ArgumentError unless params[:keywords] or params[:storeName]
      get_json_response(build_request_url('findItemsIneBayStores', params))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getHistograms.html
    def get_histograms(category_id)
      get_json_response(build_request_url('getHistograms', {:categoryId => category_id}))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getSearchKeywordsRecommendation.html
    def get_search_keywords_recommendation(keywords)
      get_json_response(build_request_url('getSearchKeywords', {:keywords => keywords}))
    end
  
    #http://developer.ebay.com/DevZone/finding/CallRef/getVersion.html
    def get_version
      get_json_response(build_request_url('getVersion'))
    end
    
    private
    def build_request_url(service, params=nil)
      url = "#{BASE_URL}?OPERATION-NAME=#{service}&SERVICE-VERSION=1.0.0&SECURITY-APPNAME=#{@app_id}ID&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD"
      unless params.nil?
        params.keys.each do |key|
          url += "&#{key}=#{params[key]}"
        end
      end
      return url
    end
    
    def get_json_response(url)
      JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
    end
  end
end