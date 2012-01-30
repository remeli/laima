#encoding: UTF-8
class Client < ActiveRecord::Base
  validates :title, :description, :presence => true
end
