# -*- encoding : utf-8 -*-
class List < ActiveRecord::Base
  
  validates :xls, :presence => true
  
  has_attached_file :xls,
    :url => "/system/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"

end
