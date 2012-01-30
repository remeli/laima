#encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  before_filter :load_services
  
  def load_services
    @services = Service.all
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
