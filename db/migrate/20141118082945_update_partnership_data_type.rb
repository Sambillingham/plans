class UpdatePartnershipDataType < ActiveRecord::Migration
    def self.up
    change_column :plans, :partnerships, :text
  end

  def self.down
    change_column :plans, :partnerships, :string
  end
end
