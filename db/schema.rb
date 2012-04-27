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

ActiveRecord::Schema.define(:version => 20120427032551) do

  create_table "applications", :force => true do |t|
    t.string   "cu_name"
    t.string   "cu_email"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.integer  "form_id"
    t.string   "excel_attachment_file_name"
    t.string   "excel_attachment_content_type"
    t.integer  "excel_attachment_file_size"
    t.datetime "excel_attachment_updated_at"
    t.string   "filled_pdf_file_name"
    t.string   "filled_pdf_content_type"
    t.integer  "filled_pdf_file_size"
    t.datetime "filled_pdf_updated_at"
  end

  create_table "carriers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "form_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.integer  "carrier_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "pdf_form_file_name"
    t.string   "pdf_form_content_type"
    t.integer  "pdf_form_file_size"
  end

  add_index "forms", ["carrier_id", "created_at"], :name => "index_forms_on_carrier_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
