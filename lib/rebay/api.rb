require 'net/http'
require 'json'
require 'uri'

module Rebay
  class Api
    # default site is EBAY_US, for other available sites see eBay documentation:
    # http://developer.ebay.com/DevZone/merchandising/docs/Concepts/SiteIDToGlobalID.html
    EBAY_US = 0

    class << self
      attr_accessor :app_id, :default_site_id, :sandbox

      def base_url
        [base_url_prefix,
         sandbox ? "sandbox" : nil,
         base_url_suffix].compact.join('.')
      end

      def base_url_prefix
        "http://svcs"
      end

      def base_url_suffix
        "ebay.com"
      end

      def sandbox
        @sandbox ||= false
      end

      def default_site_id
        @default_site_id || EBAY_US
      end

      def configure
        yield self if block_given?
      end
    end

    protected

    def get_json_response(url)
      Rebay::Response.new(JSON.parse(Net::HTTP.get_response(URI.parse(url)).body))
    end

    def build_rest_payload(params)
      payload = ''
      unless params.nil?
        params.keys.each do |key|
          if params[key].is_a?(Array)
            params[key].each_with_index do |object, index|
              payload += URI.escape "&#{key}(#{index}).name=#{object[:name]}"
              payload += URI.escape "&#{key}(#{index}).value=#{object[:value]}"
            end
          else
            payload += URI.escape "&#{key}=#{params[key]}"
          end
        end
      end
      return payload
    end
  end
end
