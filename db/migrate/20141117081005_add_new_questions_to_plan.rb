class AddNewQuestionsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :scale, :string
    add_column :plans, :opportunity, :string
    add_column :plans, :timetable, :integer
    add_column :plans, :familiarity, :integer
    add_column :plans, :past_projects, :boolean
  end
end
