#encoding:utf-8
class PagesController < ApplicationController
  def index
    @jobs = Job.random
    @title = "Главная"
    render :layout => "main"
  end
  
  def contacts
    @title = "LAIMA - Контакты"
  end
end
