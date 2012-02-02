#encoding: UTF-8
class SearchController < ApplicationController
  respond_to :html
  
  def index
    if params[:name].blank?
      flash[:notice] = "К сожалению, ничего не найдено"
      redirect_to root_path
    else
      word = '%'+params[:name]+'%'
      s_text_conditions = "SELECT * FROM services WHERE (title like ? or short_description like ? or description like ?)"
      s_conditions = [s_text_conditions, word, word, word]
      c_text_conditions = "SELECT * FROM clients WHERE (title like ?)"
      c_conditions = [c_text_conditions, word]
      @services = Service.find_by_sql(s_conditions)
      @clients = Client.find_by_sql(c_conditions)
    end
  end

end
