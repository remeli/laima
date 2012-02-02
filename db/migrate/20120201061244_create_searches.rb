class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :new
      t.string :show

      t.timestamps
    end
  end
end
