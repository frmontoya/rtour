class Contact < ActiveRecord::Base
    def self.per_page
        5
    end
	has_and_belongs_to_many :tours
	has_one                 :logo, :dependent => :destroy
	belongs_to              :occupation
	belongs_to              :person
    has_many                :properties
	validates_presence_of   :first_name, :last_name, :company, :phone, :email
    validates_presence_of   :occupation_id, :message => 'must be selected'
	validates_uniqueness_of :person_id, :scope => [ :first_name, :last_name ]
	validates_format_of :phone,
    	:message => "must be a valid telephone number.",
    	:with => /^[\(\)0-9\- \+\.]{10,20}$/
	validates_format_of :email,
		:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
		:message => 'email must be valid'
	before_save :check_is_owner
protected
	def check_is_owner	
		if self.email == person.email
			self.is_owner = true
		end
	end
	def title_full_name
		"#{title} #{first_name} #{mid_init} #{last_name}"
	end
end
