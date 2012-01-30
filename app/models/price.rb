#encoding: UTF-8
class Price < ActiveRecord::Base
  belongs_to :service
  validates :price, :service_id, :presence => true
end
