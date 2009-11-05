class Property < ActiveRecord::Base
   def self.per_page
    8
    end

    # def self.find_available_properties
    #    find(:all, :conditions => [tour_id = :tour_id])
    # end
    
    belongs_to :tour
    belongs_to :contact
    belongs_to :area
    validates_presence_of :tour_id, :contact_id, :area_id, :address, :mls, :price
    validates_presence_of :contact_id, :area_id, :message => 'must be selected'
end
    
