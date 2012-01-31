# encoding:utf-8
class ClientsController < ApplicationController
  respond_to :html
  
  def index
    @clients = Client.page(params[:page]).per(7)
    @title = @clients.title
    respond_with @clients   
  end
  
  def show
    @client = Client.find(params[:id])
    @title = @clients.title
    respond_with @client 
  end
end
