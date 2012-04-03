# -*- encoding : utf-8 -*-
class AddParentIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :parent_id, :integer
  end
end
