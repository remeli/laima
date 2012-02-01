# encoding:utf-8
class ClientsController < ApplicationController
  respond_to :html
  
  def index
    @clients = Client.page(params[:page]).per(10)
    respond_with @clients   
  end
  
end
