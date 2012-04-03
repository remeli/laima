# -*- encoding : utf-8 -*-
class DeleteDescFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :description
  end
end
