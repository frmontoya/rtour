class Area < ActiveRecord::Base
	belongs_to :location
    has_many :tour
    has_many :properties
end
