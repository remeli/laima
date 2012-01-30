#encoding: UTF-8
class Admin::ClientsController < ApplicationController
  respond_to :html
  layout 'admin'  
  
  def index
    @clients = Client.page(params[:page]).per(7)
    respond_with @clients    
  end
  
  def show
    @client = Client.find(params[:id])
    respond_with @client    
  end
  
  def new
    @client = Client.new
    respond_with @client    
  end
  
  def create
    @client = Client.create(params[:client])
    if @client.save
      flash[:notice] = "Клиент успешно добавлен!"
      respond_with(@client, :location => admin_clients_path)
    else
      render 'new'
    end    
  end
  
  def edit
    @client = Client.find(params[:id])
    respond_with @client    
  end
  
  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:notice] = "Клиент успешно обновлен!"
      respond_with(@client, :location => admin_clients_path)
    else
      render 'edit'
    end        
  end
  
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to(@client, :notice => "Клиент успешно удален!")
  end
end
