class CreateContactsTours < ActiveRecord::Migration
  def self.up
	create_table :contacts_tours, :id => false do |t|
		t.references :contact
		t.references :tour
	end	 
  end

  def self.down
	drop_table :contacts_tours
  end
end
