#encoding: UTF-8

class Service < ActiveRecord::Base
  
  has_attached_file :photo, :styles => { :small => "150x150>" },
                    :url => "/assets/services/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/services/:id/:style/:basename.:extension"
  
  validates :title, :presence => true, :length => {:maximum => 140}
  validates :description, :presence => true, :length => {:maximum => 800}
  validates :short_description, :presence => true, :length => {:maximum => 250}
  
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"
    end
  end
  
end
