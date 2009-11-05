class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
        t.integer :tour_id, :null => false
        t.integer :contact_id, :null => false
        t.integer :area_id, :null => false
        t.text      :address
        t.string    :mls, :limit => 10
        t.decimal   :price, :null => false, :precsion => 10, :scale => 2
        t.timestamps
    end
  end

  def self.down
    drop_table :properties
  end
end
