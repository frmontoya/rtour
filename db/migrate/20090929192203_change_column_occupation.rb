class ChangeColumnOccupation < ActiveRecord::Migration
  def self.up
	change_column :contacts, :occupation, :integer
  end

  def self.down
	change_column :contacts, :occupation, :string
  end
end
