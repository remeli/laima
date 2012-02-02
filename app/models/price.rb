#encoding: UTF-8
class Price < ActiveRecord::Base
  belongs_to :service
  validates :price, :service_id, :presence => true
  validates :price, :numericality => { :greater_than_or_equal_to=>0.01}
  validates :service_id, :uniqueness => true
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"      
    end
    
  end
end
