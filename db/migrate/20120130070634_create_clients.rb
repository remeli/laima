# -*- encoding : utf-8 -*-
class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
