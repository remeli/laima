#encoding: UTF-8

class UsersController < ApplicationController
  respond_to :html
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Вы успешно зарегистрировались"
      redirect_to root_path
    else
      render "new"
    end
  end
  
end
