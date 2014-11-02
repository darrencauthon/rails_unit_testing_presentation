require_relative '../../spec_helper'

describe ContactUsController do

  let(:controller) { ContactUsController.new }

  it "should be an application controller" do
    controller.is_a?(ApplicationController).must_equal true
  end

  describe "the index page" do
    it "should exist" do
      controller.index
    end
  end

  describe "submitting a contact us form" do

    let(:params) { {} }

    before do
      controller.stubs(:params).returns params
      ContactUsRequest.stubs(:create_from_a_web_visitor)
    end

    describe "and the form post was invalid" do

      let(:contact_us_request) { Struct.new(:valid?).new false }

      before do
        ContactUsRequest.expects(:create_from_a_web_visitor)
                        .with(params)
                        .returns contact_us_request
      end

      it "should pass the contact us request back to the view" do
        controller.stubs(:redirect_to)
        controller.submit
        controller.instance_eval { @contact_us_request }
                  .must_be_same_as contact_us_request
      end

      it "should not redirect" do
        controller.expects(:redirect_to).never
        controller.submit
      end

    end

    describe "and the form post was valid" do

      let(:contact_us_request) { Struct.new(:valid?).new true }

      before do
        controller.stubs(:redirect_to)
        ContactUsRequest.stubs(:create_from_a_web_visitor)
                        .with(params)
                        .returns contact_us_request
      end

      it "should save the form post to the database" do
        ContactUsRequest.expects(:create_from_a_web_visitor)
                        .with(params)
                        .returns contact_us_request
        controller.submit
      end

      it "should redirect the user to the thank you page" do
        controller.expects(:redirect_to).with '/contact_us/thank_you'
        controller.submit
      end

    end

  end

end
