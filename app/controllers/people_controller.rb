class PeopleController < ApplicationController
	before_filter :ensure_login, :only => [:edit, :update, :destroy]
  	before_filter :ensure_logout, :only => [:new, :create]
    # before_filter :work_with_tours
 
  	def index
         @tours = Tour.find(:all)
    	# @people = Person.find(:all)
  	end
 
  	def show
    	@person = Person.find(params[:id])
  	end
 
  	def new
    	@person = Person.new
  	end
 
  	def create
    	@person = Person.new(params[:person])
    	if @person.save
      		@session = @person.sessions.create
      		session[:id] = @session.id
      		flash[:notice] = "Welcome #{@person.name}, you are now registered"
      		redirect_to(root_url)
    	else
      		render(:action => 'new')
    	end
  	end
 
  	def edit
    	@person = Person.find(@user)
  	end
 
  	def update
    	@person = Person.find(@user)
    	if @person.update_attributes(params[:person])
      		flash[:notice] = "Your account has been updated"
      		redirect_to(root_url)
    	else
      		render(:action => 'edit')
    	end
  	end
 
  	def destroy
    	Person.destroy(@user)
    	session[:id] = @user = nil
    	flash[:notice] = "You are now unregistered"
    	redirect_to(root_url)
  	end

	def recover
    	person = Person.find_by_name(params[:name])
    	if person
      		Mailer.deliver_recovery(:key => Crypto.encrypt("#{person.id}:#{person.salt}"),
                              :email => person.email,
                              :domain => request.env['HTTP_HOST'])
      		flash[:notice] = "Please check your email"
      		redirect_to(root_url)
    	else
      		flash[:notice] = "Your account could not be found"
      		redirect_to(help_people_path)
    	end
  	end
	
	def new_tour
		redirect_to "/tours"
  	end
# private
    # def work_with_tours
    #    @tours = Tour.find(:all)
    # end
end
