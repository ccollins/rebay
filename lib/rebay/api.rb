require 'net/http'
require 'json'
require 'uri'

module Rebay
  class Api
    # default site is EBAY_US, for other available sites see eBay documentation:
    # http://developer.ebay.com/DevZone/merchandising/docs/Concepts/SiteIDToGlobalID.html


    class << self
      attr_accessor :app_id, :default_site_id, :sandbox

      def base_url
        [base_url_prefix,
         sandbox ? "sandbox" : nil,
         base_url_suffix].compact.join('.')
      end

      def base_url_prefix
        "https://svcs"
      end

      def base_url_suffix
        "ebay.com"
      end

      def sandbox
        @sandbox ||= false
      end

      def default_site_id
        @default_site_id ||= "EBAY-US"
      end

      def configure
        yield self if block_given?
      end
    end

    protected

    def get_json_response(url)
      uri = URI.parse(url)
      user_agent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13G34'
      response = nil
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new(uri, { 'User-Agent' => user_agent })
        response = http.request request # Net::HTTPResponse object
      end
      Rebay::Response.new(JSON.parse(response.body))
    end

    def build_rest_payload(params)
      payload = ''
      unless params.nil?
        params.keys.each do |key|
          payload += URI.escape "&#{key}=#{params[key]}"
        end
      end
      return payload
    end
  end
end
