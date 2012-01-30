#encoding: UTF-8
class Client < ActiveRecord::Base
  validates :title, :description, :presence => true
  has_attached_file :logo
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"      
    end    
  end
end
