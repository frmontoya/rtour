class Tour < ActiveRecord::Base
    attr_accessor :agent_contact_id, :escrow_officer_id, :loan_officer_id, :request_agent, :escrow_officer, :loan_officer
	has_and_belongs_to_many :contacts
    has_many :properties, :dependent => :destroy
	belongs_to :person
    belongs_to :area
	validates_presence_of :tour_name, :tour_date
    validates_presence_of :area_id, :agent_contact_id, :escrow_officer_id, :loan_officer_id, :message => 'must be selected'
    validates_uniqueness_of :area_id, :scope => [ :tour_date ]
    before_validation :check_selections
    before_save :associate_contacts_to_tours
private
    def check_selections
        self.request_agent = Contact.find_by_id(self.agent_contact_id) unless contact_has_been_associated?(self.agent_contact_id)
	    self.escrow_officer = Contact.find_by_id(self.escrow_officer_id) unless contact_has_been_associated?(self.escrow_officer_id)
        self.loan_officer = Contact.find_by_id(self.loan_officer_id) unless contact_has_been_associated?(self.escrow_officer_id)
    end
    
    def associate_contacts_to_tours
        self.contacts << self.request_agent unless contact_has_been_associated?(self.agent_contact_id)
	    self.contacts << self.loan_officer unless contact_has_been_associated?(self.loan_officer_id)
	    self.contacts << self.escrow_officer unless contact_has_been_associated?(self.escrow_officer_id)
    end

    def contact_has_been_associated?(contact)
         self.contacts.exists?(contact)
    end
end
