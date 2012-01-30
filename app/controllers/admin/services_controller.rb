#encoding: UTF-8

class Admin::ServicesController < ApplicationController
  before_filter :access
  respond_to :html
  layout 'admin'
  
  def index
    @services = Service.all
    respond_with @services
  end
  
  def show
    @service = Service.find(params[:id])
    respond_with @service
  end
  
  def new
    @service = Service.new
    respond_with @service
  end
  
  def edit
    @service = Service.find(params[:id])
    respond_with @service
  end
  
  def create
    @service = Service.new(params[:service])
    if @service.save
      flash[:notice] = "Услуга успешно добавлена"
      respond_with(@service, :location => admin_services_path)
    else
      render 'new'
    end
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:notice] = "Услуга успешно обновлена"
      respond_with(@service, :location => admin_services_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    flash[:notice] = "Услуга успешно удалена"
    redirect_to admin_services_path
  end
  
end
