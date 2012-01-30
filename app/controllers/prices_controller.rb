#encoding: UTF-8
class PricesController < ApplicationController
  respond_to :html
  
  def index
    @prices = Price.all
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
      respond_with @price
    else
      render 'new'      
    end
  end
  
  def update
    @price = Price.find(params[:id])
    if @price.update_attributes(params[:price])
      flash[:notice] = "Цена успешно обновлена!"
      respond_with @price
    else
      render 'edit'      
    end
  end
  
  def destroy
    @price = Price.find(params[:id])
    @price.destroy
    flash[:notice] = "Цена успешно удалена!"
    redirect_to @price    
  end
end
