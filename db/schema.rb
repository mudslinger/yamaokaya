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

ActiveRecord::Schema.define(version: 20140604075553) do

  create_table "entries", force: true do |t|
    t.string   "name",                 limit: 126, null: false
    t.integer  "sex",                              null: false
    t.integer  "work_type",                        null: false
    t.date     "birthday"
    t.string   "postal_code",          limit: 8
    t.string   "address",              limit: 253
    t.string   "phone",                limit: 15
    t.string   "mail_addr",            limit: 63
    t.integer  "contact_means",                    null: false
    t.integer  "work_commencing_time",             null: false
    t.integer  "work_times",           limit: 8
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip",            limit: 15
    t.float    "lat"
    t.float    "lng"
    t.integer  "area_restriction"
  end

  create_table "shops", force: true do |t|
    t.integer  "old_code"
    t.string   "name",         limit: 62,                                       null: false
    t.string   "furigana",     limit: 62
    t.string   "gname",        limit: 62
    t.string   "postal_code",  limit: 7
    t.integer  "prefecture",                                                    null: false
    t.string   "address",      limit: 127
    t.string   "phone",        limit: 15
    t.decimal  "lat",                      precision: 11, scale: 8
    t.decimal  "lng",                      precision: 11, scale: 8
    t.integer  "zoom"
    t.integer  "sunday",       limit: 8,                            default: 0, null: false
    t.integer  "monday",       limit: 8,                            default: 0, null: false
    t.integer  "tuesday",      limit: 8,                            default: 0, null: false
    t.integer  "wednesday",    limit: 8,                            default: 0, null: false
    t.integer  "thursday",     limit: 8,                            default: 0, null: false
    t.integer  "friday",       limit: 8,                            default: 0, null: false
    t.integer  "saturday",     limit: 8,                            default: 0, null: false
    t.date     "inauguration"
    t.date     "close"
    t.string   "landmarks",    limit: 127
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wished_shops", force: true do |t|
    t.integer  "entry_id"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
