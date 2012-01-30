#encoding: UTF-8
class Admin::PricesController < ApplicationController
  before_filter :access
  respond_to :html
  layout 'admin'
  
  def index
    @prices = Price.page(params[:page]).per(7)
    @services = Service.all
    respond_with @prices
  end
  
  def new
    @price = Price.new
    respond_with @price    
  end
  
  def edit
    @price = Price.find(params[:id])
    respond_with @price 
  end
  
  def show
    @price = Price.find(params[:id])
    respond_with @price 
  end
  
  def create
    @price = Price.find(params[:price])
    if @price.save
      flash[:notice] = "Цена успешно добавлена!"
      respond_with(@price, :location => admin_prices_path)
    else
      render 'new'      
    end
  end
  
  def update
    @price = Price.find(params[:id])
    if @price.update_attributes(params[:price])
      flash[:notice] = "Цена успешно обновлена!"
      respond_with(@price, :location => admin_prices_path)
    else
      render 'edit'      
    end
  end
  
  def destroy
    @price = Price.find(params[:id])
    @price.destroy
    redirect_to(@price, :notice => "Цена успешно удалена!")    
  end
end
