# encoding:utf-8
class Admin::ListsController < ApplicationController
  
  before_filter :access
  respond_to :html
  layout 'admin'

  
  def index
    @list = List.first
    respond_with @list
  end
  
  def new
    @list = List.new
    respond_with @list
  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def create
    @list = List.new(params[:list])
    if @list.save
      flash[:notice] = "Прайс-лист успешно загружен" 
      respond_with(@list, :location => admin_lists_path)
    else
      render 'new'
    end
  end
  
  def update
    @list = List.first
    if @list.update_attributes(params[:list])
      flash[:notice] = "Прайст-дист успешно обновлен"
      redirect_to admin_lists_path
    else
      render 'edit'
    end
  end
  
end
