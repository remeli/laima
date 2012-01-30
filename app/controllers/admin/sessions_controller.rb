#encoding: UTF-8

class Admin::SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Добро пожаловать!"
      redirect_to admin_path
    else
      flash.now.alert = "Неверный Email или пароль!"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Вы успешно вышли!"
    redirect_to root_path
  end
  
end