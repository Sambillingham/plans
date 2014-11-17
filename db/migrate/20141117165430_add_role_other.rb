class AddRoleOther < ActiveRecord::Migration
  def change
    add_column :plans, :role_other, :string
  end
end
