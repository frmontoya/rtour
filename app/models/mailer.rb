class Mailer < ActionMailer::Base
	
	def recovery(options)
    	from "Tours Account Recovery <recovery@techtime.info>"
    		recipients options[:email]
    	subject "Tours Account Recovery"
    	content_type 'text/html'
 
    	body :key => options[:key], :domain => options[:domain]
  	end

end
