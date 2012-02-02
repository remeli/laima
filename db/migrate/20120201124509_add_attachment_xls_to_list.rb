class AddAttachmentXlsToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :xls_file_name, :string
    add_column :lists, :xls_content_type, :string
    add_column :lists, :xls_file_size, :integer
    add_column :lists, :xls_updated_at, :datetime
  end

  def self.down
    remove_column :lists, :xls_file_name
    remove_column :lists, :xls_content_type
    remove_column :lists, :xls_file_size
    remove_column :lists, :xls_updated_at
  end
end
