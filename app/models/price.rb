#encoding: UTF-8
class Price < ActiveRecord::Base
  belongs_to :service
end
