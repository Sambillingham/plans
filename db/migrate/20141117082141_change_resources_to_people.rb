class ChangeResourcesToPeople < ActiveRecord::Migration
  def change
    rename_column :plans, :resources, :people
  end
end
