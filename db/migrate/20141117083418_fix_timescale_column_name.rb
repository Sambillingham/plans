class FixTimescaleColumnName < ActiveRecord::Migration
  def change
    rename_column :plans, :timetable, :timescale
  end
end
