#encoding: UTF-8

class Service < ActiveRecord::Base

  has_one :price, :dependent => :destroy  


  attr_accessible :title, :description, :short_description ,:photo  
  
  # relations:
  has_many :jobs, :dependent => :destroy
  

  has_attached_file :photo, :styles => { :small => "150x150>", :slider => "420x340>" },
                    :url => "/system/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  
  validates_attachment_content_type :photo, :content_type => ['image/jpeg',
                                    'image/png', 'image/gif']
                                    
  validates :title, :presence => true, :length => {:maximum => 140}, 
    :uniqueness => true
  validates :description, :presence => true, :length => {:maximum => 800}
  validates :short_description, :presence => true, :length => {:maximum => 250}
  
  def self.asctitle
    order("title ASC")
  end
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"
    end
  end
  
  def self.random
    find(:all).sample(10)
  end
  
end
# todo: сделать рандом!
