class ChangeFamiliarityDataType < ActiveRecord::Migration
  def self.up
    change_column :plans, :familiarity, :string
  end

  def self.down
    change_column :plans, :familiarity, :integer
  end
end
