class ImportsController < ApplicationController
    before_filter :ensure_login #protect controller from anonymous users
 
    def new
        @import = Import.new
    end

    def create
        @import = Import.new(params[:import])
 
        respond_to do |format|
            if @import.save!
               flash[:notice] = 'CSV data was successfully imported.'
               format.html { redirect_to(@import) }
            else
               flash[:error] = 'CSV data import failed.'
               format.html { render :action => "new" }
            end
        end
    end
 
    def show
        @import = Import.find(params[:id])
    end
 
    def proc_csv
        @import = Import.find(params[:id])
        @occupations = Occupation.find(:all)
        lines = parse_csv_file(@import.csv.path)
        lines.shift #comment this line out if your CSV file doesn't contain a header row
        if lines.size > 0
            @import.processed = lines.size
            lines.each do |line|
            case @import.datatype
                when "contacts"
                    new_contact(line)
                end
            end
            @import.save
            flash[:notice] = "CSV data processing was successful."
            redirect_to :action => "show", :id => @import.id
         else
            flash[:error] = "CSV data processing failed."
            render :action => "show", :id => @import.id
         end
    end
 
private
    
    def parse_csv_file(path_to_csv)
        lines = []
 
        #if not installed run, sudo gem install fastercsv
        #http://fastercsv.rubyforge.org/
        require 'fastercsv'
 
        FasterCSV.foreach(path_to_csv) do |row|
            lines << row
        end
        lines
     end
 
     def new_contact(line)
        params = Hash.new
        params[:contact] = Hash.new
        params[:contact]["title"] = line[0] || ""
        params[:contact]["first_name"] = line[1]
        params[:contact]["mid_init"] = line[2] || ""
        params[:contact]["last_name"] = line[3]
        params[:contact]["company"] = line[4]
        params[:contact]["phone"] = line[5]
        params[:contact]["email"] = line[6]
        params[:contact]["occupation_id"] = find_occupation(line[7])
        params[:contact]["person_id"] = @user.id
        @contact = Contact.new(params[:contact])
        if @contact.save
        end
    end
private
    def find_occupation(occupation_name)
        debugger
        occupation_id = 607123282
        for occupation in @occupations
           occupation_id = occupation.id if occupation_name == occupation.occupation
        end
        occupation_id
    end
        
end
