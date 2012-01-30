#encoding: UTF-8

class ServicesController < ApplicationController

  respond_to :html
  
  def show
    @service = Service.find(params[:id])
    @title = @service.title
    respond_with @service
  end

end