# -*- encoding : utf-8 -*-
#encoding: UTF-8

class Admin::UsersController < ApplicationController
  before_filter :access
  respond_to :html
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Вы успешно зарегистрировались"
      redirect_to admin_path
    else
      render "new"
    end
  end
  
end
