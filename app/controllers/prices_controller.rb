# encoding:utf-8
class PricesController < ApplicationController
  respond_to :html
  
  def index
    @prices = Price.all
    respond_with @prices    
  end
  
  def show
    @price = Price.find(params[:id])
    respond_with @price    
  end
end
