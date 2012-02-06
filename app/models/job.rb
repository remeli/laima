class Job < ActiveRecord::Base

  attr_accessible :title, :description, :image, :service_id

  # relations:
  belongs_to :service
  
  # validates
  validates :title, :presence => true
  validates :description, :length => { :maximum => 800 }
  
  # scope
  default_scope order('created_at DESC')

  # paperclip
  has_attached_file :image, :styles => {:thumb => "164x134>"},
    :url => "/system/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg',
    'image/png', 'image/gif']
  
  
  def self.random
    find(:all).sample(20)
  end
    
end
