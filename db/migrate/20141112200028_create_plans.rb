class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|

      t.string :role
      t.boolean :funding
      t.boolean :resources
      t.boolean :space
      t.string :partnerships

      t.timestamps
    end
  end
end
