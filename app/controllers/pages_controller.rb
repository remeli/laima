# encoding:utf-8
class PagesController < ApplicationController
  def index
    render :layout => "main"
    @title = "LAIMA - Профессиональная наружная реклама"
  end
  
  def contacts
    @title = "LAIMA - Контакты"
  end
end
