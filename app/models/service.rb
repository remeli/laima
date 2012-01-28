#encoding: UTF-8

class Service < ActiveRecord::Base
  
  validates :title, :presence => true, :length => {:maximum => 140}
  validates :description, :presence => true, :length => {:maximum => 800}
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"
    end
  end
  
end
