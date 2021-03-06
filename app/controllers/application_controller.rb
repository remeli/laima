# -*- encoding : utf-8 -*-
#encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :load_pricelist
  before_filter :load_services
  
  def load_services
    @services = Service.mains
  end

  def load_pricelist
    @list = List.first
  end
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  protected
  
  def access
    if current_user
      unless current_user
        redirect_to(root_path, :notice => "Действия запрещены")
      end        
    else
      redirect_to(log_in_path, :notice => "Пожалуйста авторизируйтесь")
    end
  end
 
end
