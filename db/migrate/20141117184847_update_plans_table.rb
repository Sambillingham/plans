class UpdatePlansTable < ActiveRecord::Migration
  def change
    add_column :plans, :resources, :string
  end
end
