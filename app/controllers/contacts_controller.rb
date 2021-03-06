class ContactsController < ApplicationController
	before_filter :ensure_login
    before_filter :return_to_tour
    before_filter :get_contacts
	
  # GET /contacts
  # GET /contacts.xml
  def index
	@contacts = Contact.find(:all)

  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    if @contact.occupation_id == 607123282
        cookies[:agent] = @contact.id.to_s
    end
    if @contact.occupation_id == 119559121
        cookies[:eofficer] = @contact.id.to_s
    end
    if @contact.occupation_id == 443816364
        cookies[:lofficer] = @contact.id.to_s
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
	@occupations = Occupation.find( :all )
    @locations = Location.find(:all)
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
	@occupations = Occupation.find( :all )
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
	@occupations = Occupation.find( :all )
    @contact = Contact.new(params[:contact])
    @locations = Location.find(:all)
	@contact.person_id = @user.id
	@logo = Logo.new(:uploaded_data => params[:logo_file])

	@service = ContactService.new(@contact, @logo)

    respond_to do |format|
      if @service.save
        flash[:notice] = 'Contact was successfully created.'
        format.html { redirect_to(@contact) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])
	@logo = @contact.logo

	@service = ContactService.new(@contact, @logo)

    respond_to do |format|
      if @service.update_attributes(params[:contact], params[:logo_file])
        flash[:notice] = 'Contact was successfully updated.'
        format.html { redirect_to(@contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

private
    def return_to_tour
        @return_url ||= cookies[:tour]
    end
    def get_contacts
        page = params[:page] || 1
        @contacts = Contact.paginate :page => page
        # @contacts = Contact.find(:all)
    end
end
