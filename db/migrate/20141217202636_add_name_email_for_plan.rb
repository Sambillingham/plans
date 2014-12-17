class AddNameEmailForPlan < ActiveRecord::Migration
  def change
    add_column :plans, :name, :string
    add_column :plans, :email, :string
  end
end
