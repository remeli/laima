# encoding:utf-8
class Admin::PricelistController < ApplicationController
  
  before_filter :access
  respond_to :html
  layout 'admin'
  
  def index
    
  end
  
  def upload
    @file = params[:file]
    
  end
  
end
