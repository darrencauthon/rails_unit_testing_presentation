class ContactUsController < ApplicationController
  def index
  end

  def submit
    @contact_us_request = ContactUsRequest.create_from_a_web_visitor params
    if @contact_us_request.valid?
      redirect_to '/contact_us/thank_you'
    end
  end
end
