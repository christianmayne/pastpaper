# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120604124628) do

  create_table "attribute_documents", :force => true do |t|
    t.integer  "document_id"
    t.integer  "attribute_type_id"
    t.string   "value"
    t.date     "on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attribute_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_facts", :force => true do |t|
    t.integer  "document_id"
    t.integer  "fact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_photos", :force => true do |t|
    t.integer  "document_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_primary",         :default => false
  end

  create_table "document_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.integer  "status_id"
    t.integer  "document_type_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "title"
    t.integer  "length"
    t.integer  "width"
    t.integer  "weight"
    t.integer  "depth"
    t.integer  "edition"
    t.integer  "pages"
    t.text     "condition"
    t.text     "binding"
    t.text     "comment"
    t.string   "stock_number"
    t.date     "purchase_date"
    t.decimal  "purchase_price",   :precision => 10, :scale => 0
    t.string   "purchase_vendor"
    t.date     "sale_date"
    t.decimal  "sale_price",       :precision => 10, :scale => 0
    t.string   "sale_purchaser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_deleted",                                      :default => false
    t.boolean  "is_featured",                                     :default => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order"
  end

  create_table "facts", :force => true do |t|
    t.integer  "person_id"
    t.integer  "event_type_id"
    t.integer  "location_id"
    t.date     "fact_date"
    t.string   "date_modifier"
    t.integer  "fact_year"
    t.integer  "fact_month"
    t.integer  "fact_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "document_id"
    t.string   "street1"
    t.string   "street2"
    t.string   "county"
    t.string   "town"
    t.string   "country"
    t.string   "additional_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "orders", :force => true do |t|
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "document_id"
    t.string   "invoice"
    t.string   "document_name"
    t.string   "item_number"
    t.string   "buyer_email"
    t.string   "buyer_first_name"
    t.string   "buyer_last_name"
    t.string   "buyer_address1"
    t.string   "buyer_address2"
    t.string   "buyer_postcode"
    t.string   "buyer_city"
    t.string   "buyer_country"
    t.decimal  "amount",           :precision => 10, :scale => 0
    t.string   "paypal_status"
    t.string   "paypal_txn_no"
    t.boolean  "paid_status",                                     :default => false
    t.text     "paypal_ipn_msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.integer  "document_id"
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "maiden_name"
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_events", :force => true do |t|
    t.integer  "person_id"
    t.integer  "event_type_id"
    t.date     "date_event"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "town"
    t.string   "county"
    t.string   "country"
    t.string   "additional_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date_modifier"
    t.integer  "event_year"
    t.integer  "event_month"
    t.integer  "event_day"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                           :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.boolean  "is_admin",                        :default => false
    t.boolean  "is_active",                       :default => true
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "post_code"
    t.string   "country"
    t.string   "tel_number"
    t.string   "mobile_number"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
