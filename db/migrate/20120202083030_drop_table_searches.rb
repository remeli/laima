class DropTableSearches < ActiveRecord::Migration
  def up
    drop_table :searches
  end

  def down
  end
end
