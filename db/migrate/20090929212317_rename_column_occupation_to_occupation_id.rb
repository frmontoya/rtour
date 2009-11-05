class RenameColumnOccupationToOccupationId < ActiveRecord::Migration
  def self.up
	rename_column :contacts, :occupation, :occupation_id
  end

  def self.down
	rename_column :contacts, :occupation_id, :occupation
  end
end
