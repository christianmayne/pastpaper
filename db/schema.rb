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

ActiveRecord::Schema.define(:version => 20120922162609) do

  create_table "attribute_documents", :force => true do |t|
    t.integer  "document_id"
    t.integer  "attribute_type_id"
    t.string   "value"
    t.date     "on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date_modifier"
    t.integer  "attribute_year"
    t.integer  "attribute_month"
    t.integer  "attribute_day"
    t.string   "attribute_location"
  end

  create_table "attribute_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document_id"
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
    t.boolean  "paper",       :default => true
    t.boolean  "stone",       :default => true
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
    t.integer  "views",                                           :default => 0
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

  create_table "gedcom_documents", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "description"
  end

  create_table "gedcom_facts", :force => true do |t|
    t.integer  "gedcom_person_id"
    t.string   "kind"
    t.string   "date_modifier"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gedcom_people", :force => true do |t|
    t.integer  "gedcom_document_id"
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "maiden_name"
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_countries", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.decimal  "longitude",  :precision => 10, :scale => 0
    t.decimal  "latitude",   :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order",                                :default => 999
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

  create_table "shipping_zone_prices", :force => true do |t|
    t.integer  "shipping_zone_id"
    t.decimal  "weight_g",         :precision => 10, :scale => 0
    t.decimal  "price",            :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_zones", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "site_profiles", :force => true do |t|
    t.integer  "site_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "site_name"
    t.string   "site_url"
    t.string   "profile_name"
    t.boolean  "selling_enabled",          :default => true
    t.boolean  "popover_enabled",          :default => false
    t.string   "popover_heading"
    t.boolean  "popover_mailinglist_form", :default => true
    t.boolean  "popover_login_form",       :default => true
    t.text     "popover_message"
    t.boolean  "listing_enabled",          :default => true
    t.boolean  "preview_mode",             :default => true
  end

  create_table "site_statuses", :force => true do |t|
    t.string   "status"
    t.string   "description"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "heading"
    t.boolean  "login_form"
    t.boolean  "mailing_list_form"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "show_latest_items"
    t.integer  "show_my_items"
    t.integer  "show_featured_items"
    t.integer  "show_search_results"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
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
    t.boolean  "interest_familyhistory",          :default => false
    t.boolean  "interest_localhistory",           :default => false
    t.boolean  "interest_oldbooks",               :default => false
    t.boolean  "interest_olddocuments",           :default => false
    t.boolean  "interest_oldnewspapers",          :default => false
    t.boolean  "interest_oldphotos",              :default => false
    t.boolean  "interest_oldpostcards",           :default => false
    t.boolean  "interest_other",                  :default => false
    t.string   "interest_other_text"
    t.boolean  "terms_accepted",                  :default => false
    t.boolean  "dealer_account",                  :default => false
    t.boolean  "is_dealer",                       :default => false
    t.integer  "location_country_id"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
