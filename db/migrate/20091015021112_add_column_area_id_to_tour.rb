class AddColumnAreaIdToTour < ActiveRecord::Migration
  def self.up
    add_column :tours, :area_id, :integer
  end

  def self.down
    remove_column :tours, :area_id
  end
end
