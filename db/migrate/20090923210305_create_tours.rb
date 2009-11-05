class CreateTours < ActiveRecord::Migration
  def self.up
    create_table :tours do |t|
      t.string :tour_name
      t.datetime :tour_date

      t.timestamps
    end
  end

  def self.down
    drop_table :tours
  end
end
