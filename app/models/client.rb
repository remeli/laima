#encoding: UTF-8
class Client < ActiveRecord::Base
  validates :title, :presence => true
  
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "120x80>" },
                    :url => "/system/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
  validates_attachment_presence :logo
  validates_attachment_size :logo, :less_than => 5.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  default_scope order('title ASC')    
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"      
    end    
  end
end
