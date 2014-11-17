class ChangePastProjectsDataType < ActiveRecord::Migration
def self.up
    change_column :plans, :past_projects, :string
  end

  def self.down
    change_column :plans, :past_projects, :boolean
  end
end
