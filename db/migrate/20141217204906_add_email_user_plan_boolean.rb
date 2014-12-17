class AddEmailUserPlanBoolean < ActiveRecord::Migration
  def change
    add_column :plans, :email_user_plan, :boolean
  end
end
