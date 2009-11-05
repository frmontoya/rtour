class CreateLogos < ActiveRecord::Migration
  def self.up
    create_table :logos do |t|
  		t.integer :contact_id, :parent_id, :size, :width, :height
  		t.string :content_type, :filename, :thumbnail
  		t.timestamps
    end
  end

  def self.down
    drop_table :logos
  end
end
