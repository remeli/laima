class Job < ActiveRecord::Base
  # validates
  validations :title, :presence => true
  validation :description, :length => { :maximum => 800 }
  
  # scope
  default_scope order('created_at DESC')
  
end
