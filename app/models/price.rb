# -*- encoding : utf-8 -*-
#encoding: UTF-8
class Price < ActiveRecord::Base
  belongs_to :service
  validates :service_id, :presence => true
  validates :service_id, :uniqueness => true
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"      
    end
    
  end
end
