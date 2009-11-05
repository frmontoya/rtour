module ContactsHelper
	def logo_for(contact, size = :medium)
   		if contact.logo
     		logo_image = contact.logo.public_filename(size)
     		link_to image_tag(logo_image), contact.logo.public_filename
   		else
     		image_tag("blank-logo-#{size}.png" )
   		end
	end
end
