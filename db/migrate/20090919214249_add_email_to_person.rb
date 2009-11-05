class AddEmailToPerson < ActiveRecord::Migration
  def self.up
	change_table :people do |t|
		t.string :email
	end
  end

  def self.down
	change_table :people do |t|
		t.remove :email
	end
  end
end
