class RelationBetwenServicesAndJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :service_id, :integer
  end
end