class ToursController < ApplicationController
  before_filter :ensure_login
  before_filter :get_user_contacts
  before_filter :get_selected_contacts, :only => [:new]
  # GET /tours
  # GET /tours.xml
  def index
	@tours = Tour.find(:all)
  end

  # GET /tours/1
  # GET /tours/1.xml
  def show
    @tour = Tour.find(params[:id])
    page = params[:page] || 1
    @properties = Property.paginate_by_tour_id @tour.id, :page => page

    cookies.delete :agent
    cookies.delete :eofficer
    cookies.delete :lofficer

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tour }
    end
  end

  # GET /tours/new
  # GET /tours/new.xml
  def new
    @areas = Area.find( :all )
    @tour = Tour.new
    page = params[:page] || 1
    @properties = Property.paginate_by_tour_id @tour.id, :page => page

    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.xml  { render :xml => @tour }
    # end
  end

  # GET /tours/1/edit
  def edit
    @tour = Tour.find(params[:id])
    @tour_contacts = @tour.contacts
    @tour.request_agent = @tour_contacts.find_by_occupation_id(607123282)
    @tour.escrow_officer = @tour_contacts.find_by_occupation_id(119559121)
    @tour.loan_officer = @tour_contacts.find_by_occupation_id(443816364)
    @tour.agent_contact_id = @tour.request_agent.id
    @tour.escrow_officer_id = @tour.escrow_officer.id
    @tour.loan_officer_id = @tour.loan_officer.id
    page = params[:page] || 1
    @properties = Property.paginate_by_tour_id @tour.id, :page => page
    # @properties = @tour.properties
  end

  # POST /tours
  # POST /tours.xml
  def create
    @areas = Area.find( :all )
    @tour = Tour.new(params[:tour])
    @tour.agent_contact_id = params[:agent][:contact_id]
    @tour.escrow_officer_id = params[:eofficer][:contact_id]
    @tour.loan_officer_id = params[:lofficer][:contact_id]
	# @agent = Contact.find(params[:agent][:contact_id])
	# @loan_officer = Contact.find(params[:lofficer][:contact_id])
	# @escrow_officer = Contact.find(params[:eofficer][:contact_id])

    respond_to do |format|
      if @tour.save
        flash[:notice] = 'Tour was successfully created.'
        format.html { redirect_to(@tour) }
        format.xml  { render :xml => @tour, :status => :created, :location => @tour }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tours/1
  # PUT /tours/1.xml
  def update
    @tour = Tour.find(params[:id])
    @tour.agent_contact_id = params[:agent][:contact_id]
    @tour.escrow_officer_id = params[:eofficer][:contact_id]
    @tour.loan_officer_id = params[:lofficer][:contact_id]     
    respond_to do |format|
        if @tour.update_attributes(params[:tour])
            flash[:notice] = 'Tour was successfully updated.'
            format.html { redirect_to(@tour) }
            format.xml  { head :ok }
        else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
        end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.xml
  def destroy
    @tour = Tour.find(params[:id])
    @tour.destroy

    respond_to do |format|
      format.html { redirect_to(tours_url) }
      format.xml  { head :ok }
    end
  end
	
  def get_tours
    @tours = Tours.find(:all)
  end 
  private
	def get_user_contacts
		@agents = Contact.find(:all, :conditions =>  "occupation_id = 607123282" )
		@eofficers = Contact.find(:all, :conditions => "occupation_id = 119559121")
    	@lofficers = Contact.find(:all, :conditions => "occupation_id = 443816364")
        @locations = Location.find(:all)
	end
    def get_selected_contacts
        @agent ||= cookies[:agent]
        @eofficer ||= cookies[:eofficer]
        @lofficer ||= cookies[:lofficer]
    end
        
end
