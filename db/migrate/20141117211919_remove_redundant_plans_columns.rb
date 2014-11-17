class RemoveRedundantPlansColumns < ActiveRecord::Migration
  def self.up
    remove_column :plans, :people
    remove_column :plans, :funding
    remove_column :plans, :space
  end
  def self.down
    add_column :plans, :people, :boolean
    add_column :plans, :funding, :boolean
    add_column :plans, :space, :boolean
  end
end
