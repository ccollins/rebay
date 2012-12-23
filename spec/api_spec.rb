require File.dirname(__FILE__) + '/spec_helper'


module Rebay
  describe Api do
    describe "#configure" do
      it "should respond to configure" do
        Rebay::Api.should respond_to(:configure)
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
        payload = @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah'})
        payload.should include("&test=blah")
        payload.should include("&test2=blah")
        payload.should include("&test3=blah")
      end

      it "should escape html chars" do
         payload = @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah blah'})
         payload.should include("&test=blah")
         payload.should include("&test2=blah")
         payload.should include("&test3=blah%20blah")
      end
    end
  end
end
