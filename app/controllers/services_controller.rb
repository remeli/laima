#encoding: UTF-8

class ServicesController < ApplicationController

  respond_to :html
  
  def index
    @services = Service.all
    respond_with @services
  end
  
  def show
    @service = Service.find(params[:id])
    respond_with @service
  end

end