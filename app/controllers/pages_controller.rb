# encoding:utf-8
class PagesController < ApplicationController
  def index
    @jobs = Job.all
    @title = "LAIMA - Профессиональная наружная реклама"
    render :layout => "main"
  end
  
  def contacts
    @title = "LAIMA - Контакты"
  end
end
