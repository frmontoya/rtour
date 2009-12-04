class PropertiesController < ApplicationController
   before_filter :ensure_login
   before_filter :get_user_contacts
   before_filter :get_selected_contacts, :only => [:new]
   before_filter :retreive_properties
    before_filter :lookup_geocodes, :only => [:create]

   def index
    @properties = Property.find_available_properties
   end

    def new   
        @property = @tour.properties.new
        cookies[:tour] = @tour.id.to_s
   
        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @property }
        end
   end

   def edit
        @property = @tour.properties.find(params[:id])
        cookies[:tour] = @tour.id.to_s
   end

   def create
        @property = @tour.properties.new(params[:property])
        respond_to do |format|
            if @property.save
                flash[:notice] = 'Propery was successfully created.'
                format.html { redirect_to([@tour, @property]) }
                format.xml  { render :xml => @property, :status => :created, :location => [@tour, @property] }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @propery.errors, :status => :unprocessable_entity }
            end
        end
   end

    def update
        @property = Property.find(params[:id])

        respond_to do |format|
            if @property.update_attributes(params[:property])
                flash[:notice] = 'Property was successfully updated.'
                format.html { redirect_to([@tour, @property]) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @property = @tour.properties.find(params[:id])

        cookies.delete :agent
        cookies.delete :tour

        respond_to do |format|
            format.html # show.html.erb
            format.xml { render :xml => @property }
        end
    end

    def destroy
        @property = Property.find(params[:id])
        @property.destroy

        respond_to do |format|
            format.html { redirect_to(tour_properties_url) }
            format.xml  { head :ok }
        end
    end

private
   def get_user_contacts
        @tour = Tour.find(params[:tour_id])     
        @tour_contacts = @tour.contacts
        @tour.request_agent = @tour_contacts.find_by_occupation_id(607123282)
        @tour.escrow_officer = @tour_contacts.find_by_occupation_id(119559121)
        @tour.loan_officer = @tour_contacts.find_by_occupation_id(443816364)
        @tour.agent_contact_id = @tour.request_agent.id
        @tour.escrow_officer_id = @tour.escrow_officer.id
        @tour.loan_officer_id = @tour.loan_officer.id     
        @agents = Contact.find(:all, :conditions =>  "occupation_id = 607123282" )
        @eofficers = Contact.find(:all, :conditions => "occupation_id = 119559121")
        @lofficers = Contact.find(:all, :conditions => "occupation_id = 443816364")
        @locations = Location.find(:all)
   end
   def get_selected_contacts
        @agent ||= cookies[:agent]
    end 
    def retreive_properties
        @properties = Property.paginate_by_tour_id @tour.id, :page => params[:page]
        # @properties = @tours.properties.paginate(:all, :page => params[:page])
    end
     def lookup_geocodes
        geocodes = get_geocode params[:property][:address]
        params[:property][:lat] = geocode[:latitude]
        params[:property][:lng] = geocode[:longitude]
    end
    def get_geocode(address)
        logger.debug 'starting geocoder call for address: '+address
        # this is where we call the geocoding web service
        server = XMLRPC::Client.new2('http://rpc.geocoder.us/service/xmlrpc')
        result = server.call2('geocode', address)
        logger.debug "Geocode call: "+result.inspect
    
        return {:success=> true, :latitude=> result[1][0]['lat'], 
		    :longitude=> result[1][0]['long']}
  end 
end
