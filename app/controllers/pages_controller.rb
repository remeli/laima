# -*- encoding : utf-8 -*-
#encoding:utf-8
class PagesController < ApplicationController
  def index
    @jobs = Job.random
    @sliders = Service.random
    @title = "Главная"
    render :layout => "main"
  end
  
  def contacts
    @title = "Контакты"
  end
end
