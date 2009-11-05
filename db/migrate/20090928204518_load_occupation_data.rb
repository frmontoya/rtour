require 'active_record/fixtures'
class LoadOccupationData < ActiveRecord::Migration
  def self.up
	down
  	directory = File.join(File.dirname(__FILE__), "data")
  	Fixtures.create_fixtures(directory, "occupations")
  end

  def self.down
	 Occupation.delete_all
  end
end
