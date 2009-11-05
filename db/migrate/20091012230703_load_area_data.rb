require 'active_record/fixtures'
class LoadAreaData < ActiveRecord::Migration
  def self.up
	down
  	directory = File.join(File.dirname(__FILE__), "data")
  	Fixtures.create_fixtures(directory, "areas")
  end

  def self.down
	Area.delete_all
  end
end
