class CommentForPrice < ActiveRecord::Migration
  def change
    add_column :prices, :comment, :text
  end
end