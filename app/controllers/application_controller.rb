class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_services
  
  def load_services
    @services = Service.all
  end
end
