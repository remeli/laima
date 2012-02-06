#encoding: UTF-8

class ServicesController < ApplicationController

  respond_to :html
  
  def index
    @title = "Услуги"
  end
  
  def show
    @service = Service.find(params[:id])
    @title = @service.title
    @jobs = @service.jobs.page(params[:page]).per(8)
    respond_with @service
  end

end