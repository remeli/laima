#encoding:utf-8
class AdminController < ApplicationController
  before_filter :access
  
  def index
    render :layout => "admin"
  end
end
