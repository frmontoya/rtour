class ContactService
  attr_reader :contact, :logo
  def initialize(contact, logo)
    @contact = contact
    @logo = logo
  end
  def save
    return false unless valid?
    begin
      Contact.transaction do
        if @logo.new_record?
          @contact.logo.destroy if @contact.logo
          @logo.contact = @contact
          @logo.save!
        end
        @contact.save!
        true
      end
    rescue
      false
    end
  end
  def valid?
    @contact.valid? && @logo.valid?
  end
  def update_attributes(contact_attributes, logo_file)
  	@contact.attributes = contact_attributes
  	unless logo_file.blank?
    	@logo = Logo.new(:uploaded_data => logo_file)
  	end
  	save
  end

end

