class FixDataTypeForResources < ActiveRecord::Migration
  def self.up
    change_column :plans, :resources, :text
  end

  def self.down
    change_column :plans, :resources, :string
  end
end
