# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

	before_filter :maintain_session_and_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '363ca7716b51abb21a045db705da3926'

	def ensure_login
    	unless @user
      		flash[:notice] = "Please login to continue"
      		redirect_to(new_session_path)
    	end
  	end
 
  	def ensure_logout
    	if @user
      		flash[:notice] = "You must logout before you can login or register"
      		redirect_to(root_url)
    	end
  	end
 
  private
 
  	def maintain_session_and_user
    	if session[:id]
      		if @application_session = Session.find_by_id(session[:id])
        		@application_session.update_attributes(:ip_address => request.remote_addr, :path => request.path_info)
        		@user = @application_session.person
      		else
        		session[:id] = nil
        		redirect_to(root_url)
      		end
    	end
  	end

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
