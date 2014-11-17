class AddSecondLevelQuestionsForResources < ActiveRecord::Migration
  def change
    add_column :plans, :funding_how, :boolean
    add_column :plans, :recruit_volunteers, :boolean
  end
end
