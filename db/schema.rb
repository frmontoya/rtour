# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091028223028) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.boolean  "is_owner"
    t.string   "first_name"
    t.string   "mid_init"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "title"
    t.string   "company"
    t.string   "phone"
    t.string   "email"
    t.string   "logo"
    t.integer  "occupation_id", :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
  end

  create_table "contacts_tours", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "tour_id"
  end

  create_table "imports", :force => true do |t|
    t.string   "datatype"
    t.integer  "processed",        :default => 0
    t.string   "csv_file_name"
    t.string   "csv_content_type"
    t.integer  "csv_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logos", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "parent_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupations", :force => true do |t|
    t.string   "occupation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "salt"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "properties", :force => true do |t|
    t.integer  "tour_id",                  :null => false
    t.integer  "contact_id",               :null => false
    t.integer  "area_id",                  :null => false
    t.text     "address"
    t.string   "mls",        :limit => 10
    t.decimal  "price",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.integer  "person_id"
    t.string   "ip_address"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tours", :force => true do |t|
    t.string   "tour_name"
    t.datetime "tour_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "area_id"
  end

end
