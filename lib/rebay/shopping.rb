module Rebay
  class Shopping < Rebay::Api
    BASE_URL = 'http://open.api.ebay.com/Shopping'
    VERSION = '677'
    
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
      #http://open.api.ebay.com/Shopping?callname=GetCategoryInfo&appid=searched-8e3a-4e50-af08-c2e48cb3b020&version=677&siteid=0&CategoryID=1&responseencoding=JSON&IncludeSelector=ChildCategories
      url = "#{BASE_URL}?callname=#{service}&appid=#{Rebay::Api.app_id}&version=#{VERSION}&responseencoding=JSON&siteid=#{Rebay::Api.EBAY_US}"
      url += build_rest_payload(params)
      return url
    end
  end
end