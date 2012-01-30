# encoding:utf-8
class ClientsController < ApplicationController
  respond_to :html
  
  def index
    @clients = Client.all
    respond_with @clients   
  end
  
  def show
    @client = Client.find(params[:id])
    respond_with @client 
  end
end
