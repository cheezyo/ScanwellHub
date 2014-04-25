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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140425131630) do

  create_table "activity_logs", force: true do |t|
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
    t.string   "params"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_per_unit"
  end

  create_table "comp_todos", force: true do |t|
    t.integer  "todo_id"
    t.string   "level"
    t.text     "task"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "component_id"
    t.string   "title"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "components", force: true do |t|
    t.string   "comp_id"
    t.date     "last_check"
    t.integer  "unit_id"
    t.integer  "brand_id"
    t.boolean  "available"
    t.boolean  "calibrated"
    t.text     "commet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "range"
    t.integer  "client_id"
    t.string   "serial_nr"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "more"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "country"
    t.integer  "status"
  end

  create_table "logcomponents", force: true do |t|
    t.integer  "component_id"
    t.date     "send_date"
    t.integer  "sent_from"
    t.integer  "sent_by"
    t.integer  "sent_to"
    t.integer  "on_unit"
    t.date     "arrive_date"
    t.integer  "recived_by"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.integer  "package_id"
  end

  create_table "logunits", force: true do |t|
    t.integer  "unit_id"
    t.date     "send_date"
    t.integer  "sent_by"
    t.integer  "sent_from"
    t.integer  "sent_to"
    t.date     "arrive_date"
    t.integer  "recived_by"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.integer  "package_id"
  end

  create_table "packages", force: true do |t|
    t.integer  "origin"
    t.integer  "destiantion"
    t.date     "arrival_date"
    t.integer  "reciver"
    t.integer  "status"
    t.string   "po"
    t.string   "ref"
    t.text     "coment"
    t.string   "pack_nr"
    t.text     "unit_ids"
    t.text     "components_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", force: true do |t|
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackings", force: true do |t|
    t.integer  "status_id"
    t.integer  "unit_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from"
    t.integer  "to"
    t.string   "action_name"
    t.integer  "user_id"
  end

  create_table "unit_names", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_todos", force: true do |t|
    t.integer  "todo_id"
    t.string   "level"
    t.text     "task"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unit_id"
    t.string   "title"
  end

  create_table "units", force: true do |t|
    t.string   "unit_id"
    t.integer  "location"
    t.date     "last_check"
    t.boolean  "available"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "tracking_id"
    t.integer  "client_id"
    t.integer  "unit_name_id"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.integer  "company_id"
    t.boolean  "super_admin"
    t.boolean  "admin"
    t.boolean  "operator"
  end

end
