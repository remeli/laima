#encoding: UTF-8
class Price < ActiveRecord::Base
  belongs_to :service
  validates :price, :service_id, :presence => true
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"      
    end
    
  end
end
