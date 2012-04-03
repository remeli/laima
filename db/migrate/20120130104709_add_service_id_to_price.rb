# -*- encoding : utf-8 -*-
class AddServiceIdToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :service_id, :integer
  end
end
