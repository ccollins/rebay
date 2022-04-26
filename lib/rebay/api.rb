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

    attr_accessor :proxy_url, :proxy_port, :proxy_username, :proxy_password, :user_agent

    def initialize(proxy_url: nil, proxy_port: nil, proxy_username: nil, proxy_password: nil, user_agent: 'eBayiPhone/6.24.0')
      @proxy_url = proxy_url
      @proxy_port = proxy_port
      @proxy_username = proxy_username
      @proxy_password = proxy_password
      @user_agent = user_agent
    end

    protected

    def get_json_response(url, headers: {})
      uri = URI.parse(url)
      response = nil
      Net::HTTP.start(uri.host, 443, proxy_url, proxy_port, proxy_username, proxy_password, use_ssl: true) do |http|
        request = Net::HTTP::Get.new(uri, { 'User-Agent' => user_agent }.merge(headers))
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
