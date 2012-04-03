# -*- encoding : utf-8 -*-
class EditPrice < ActiveRecord::Migration
  def change
    change_column :prices, :price, :string
  end
end
