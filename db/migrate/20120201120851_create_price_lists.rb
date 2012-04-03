# -*- encoding : utf-8 -*-
class CreatePriceLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|

      t.timestamps
    end
  end
end
