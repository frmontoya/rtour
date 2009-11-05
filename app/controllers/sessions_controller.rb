class SessionsController < ApplicationController
	before_filter :ensure_login, :only => :destroy
  	before_filter :ensure_logout, :only => [:new, :create]
 
  	def index
    	redirect_to(new_session_path)
  	end
 
  	def new
    	@session = Session.new
  	end
 
  	def create
    	@session = Session.new(params[:session])
    	if @session.save
      		session[:id] = @session.id
      		flash[:notice] = "Hello #{@session.person.name}, you are now logged in"
      		redirect_to(root_url)
    	else
      		render(:action => 'new')
    	end
  	end
 
  	def destroy
    	Session.destroy(@application_session)
    	session[:id] = @user = nil
    	flash[:notice] = "You are now logged out"
    	redirect_to(root_url)
  	end

	def recovery
    	begin
      		key = Crypto.decrypt(params[:id]).split(/:/)
      		@session = Person.find(key[0], :conditions => {:salt => key[1]}).sessions.create
      		session[:id] = @session.id
      		flash[:notice] = "Please change your password"
      		redirect_to(edit_person_path('account'))
    	rescue ActiveRecord::RecordNotFound
      		flash[:notice] = "The recovery link given is not valid"
      		redirect_to(root_url)
    	end
  	end


end
