class AddCheckForEmailSent < ActiveRecord::Migration
  def change
    add_column :plans, :email_sent, :boolean, :default => false
  end
end
