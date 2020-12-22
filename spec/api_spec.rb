require File.dirname(__FILE__) + '/spec_helper'


module Rebay
  describe Api do
    describe "#configure" do
      it "should respond to configure" do
        Rebay::Api.should respond_to(:configure)
      end

      describe "#base_url_prefix" do
        it "shouldn't be nil" do
          Rebay::Api.base_url_prefix.should_not be_nil
        end
      end

      describe "#base_url_suffix" do
        it "shouldn't be nil" do
          Rebay::Api.base_url_suffix.should_not be_nil
        end
      end

      describe "#base_url" do
        context "api calls should hit the sandbox" do
          it "should return a sandboxed url" do
            Rebay::Api.configure do |c|
              c.sandbox = true
            end

            Rebay::Api.base_url.should include "sandbox"
          end
        end

        context "api calls shouldn't hit the sandbox" do
          it "should return a un-sandboxed url" do
            Rebay::Api.configure do |c|
              c.sandbox = false
            end

            Rebay::Api.base_url.should_not include "sandbox"
          end
        end
      end

      describe "#sandbox" do
        it_behaves_like "a configuration option", :sandbox, true
      end

      describe "#app_id" do
        it_behaves_like "a configuration option", :app_id, 'super_id-11'
      end

      describe "#default_site_id" do
        it_behaves_like "a configuration option", :default_site_id, 100

        it "should default to EBAY_US" do
          Rebay::Api.default_site_id.should eq Rebay::Api::EBAY_US
        end
      end
    end

    context "when calling build_rest_payload" do
      before(:each) do
        @api = Rebay::Api.new
      end

      it "should build rest payload from hash" do
        payload = @api.send(:build_rest_payload, { :test => 'blah', :test2 => 'blah', :test3 => 'blah' })
        payload.should include("&test=blah")
        payload.should include("&test2=blah")
        payload.should include("&test3=blah")
      end

      it "should escape html chars" do
        payload = @api.send(:build_rest_payload, { :test => 'blah', :test2 => 'blah', :test3 => 'blah blah' })
        payload.should include("&test=blah")
        payload.should include("&test2=blah")
        payload.should include("&test3=blah%20blah")
      end
    end

    context 'shopping' do
      it 'can set the app id during the request' do
        Rebay::Api.configure do |c|
          c.app_id = 'super_id-11'
        end

        request_url = Rebay::Shopping.new.send(:build_request_url, 'shopping', { app_id: 'foo' })
        expect(request_url.include?('appid=foo')).to eq(true)
      end
    end

    context 'finding' do
      it 'can set the app id during the request' do
        Rebay::Api.configure do |c|
          c.app_id = 'super_id-11'
        end

        request_url = Rebay::Finding.new.send(:build_request_url, 'finding', { app_id: 'foo' })
        expect(request_url.include?('SECURITY-APPNAME=foo')).to eq(true)
      end
    end
  end
end
