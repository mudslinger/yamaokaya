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

ActiveRecord::Schema.define(version: 20160421091140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgres_fdw"

  create_table "allergen_labellings", force: true do |t|
    t.integer   "menu_id"
    t.integer   "allergen_id"
    t.integer   "label"
    t.timestamp "created_at",  precision: 6
    t.timestamp "updated_at",  precision: 6
  end

  create_table "allergens", force: true do |t|
    t.string    "name",                     null: false
    t.integer   "division"
    t.timestamp "created_at", precision: 6
    t.timestamp "updated_at", precision: 6
  end

  create_table "areas", force: true do |t|
    t.integer   "prefecture_id"
    t.string    "name",          limit: 62,               null: false
    t.integer   "start_shows"
    t.integer   "end_shows"
    t.timestamp "created_at",               precision: 6
    t.timestamp "updated_at",               precision: 6
    t.integer   "seq"
  end

  create_table "entries", force: true do |t|
    t.string    "name",                 limit: 126,               null: false
    t.integer   "sex",                                            null: false
    t.integer   "work_type",                                      null: false
    t.date      "birthday"
    t.string    "postal_code",          limit: 8
    t.string    "address",              limit: 253
    t.string    "phone",                limit: 15
    t.string    "mail_addr",            limit: 63
    t.integer   "contact_means",                                  null: false
    t.integer   "work_commencing_time",                           null: false
    t.integer   "work_times",           limit: 8
    t.text      "message"
    t.timestamp "created_at",                       precision: 6
    t.timestamp "updated_at",                       precision: 6
    t.string    "remote_ip",            limit: 15
    t.float     "lat"
    t.float     "lng"
    t.integer   "area_restriction"
    t.boolean   "mail_sent"
  end

  create_table "feedbacks", force: true do |t|
    t.string    "mail_addr",   limit: 126,               null: false
    t.string    "name",        limit: 62,                null: false
    t.integer   "age"
    t.boolean   "male"
    t.string    "address",     limit: 254
    t.string    "phone",       limit: 30,                null: false
    t.float     "lat"
    t.float     "lng"
    t.string    "region",      limit: 254
    t.integer   "shop_id"
    t.integer   "menu_id"
    t.date      "visit_date"
    t.integer   "visit_time"
    t.integer   "repetition"
    t.timestamp "created_at",              precision: 6
    t.timestamp "updated_at",              precision: 6
    t.integer   "quality"
    t.integer   "service"
    t.integer   "cleanliness"
    t.integer   "atomosphere"
    t.boolean   "reply"
    t.text      "message"
    t.boolean   "mail_sent"
    t.string    "remote_ip",   limit: 15,                null: false
  end

  create_table "menus", force: true do |t|
    t.string    "name",            limit: 126,               null: false
    t.integer   "category",                                  null: false
    t.integer   "subcategory",                               null: false
    t.integer   "taste"
    t.integer   "ingredients"
    t.boolean   "has_large_sizes"
    t.boolean   "is_hot"
    t.date      "start_sells",                               null: false
    t.date      "end_sells",                                 null: false
    t.date      "start_promote"
    t.date      "end_promote"
    t.integer   "price",                                     null: false
    t.text      "comment"
    t.integer   "push_priority"
    t.timestamp "created_at",                  precision: 6
    t.timestamp "updated_at",                  precision: 6
  end

  create_table "prefectures", force: true do |t|
    t.integer   "region_id"
    t.string    "name",        limit: 62,               null: false
    t.integer   "start_shows"
    t.integer   "end_shows"
    t.timestamp "created_at",             precision: 6
    t.timestamp "updated_at",             precision: 6
    t.integer   "seq"
  end

  create_table "regions", force: true do |t|
    t.string    "name",        limit: 62,               null: false
    t.integer   "start_shows"
    t.integer   "end_shows"
    t.timestamp "created_at",             precision: 6
    t.timestamp "updated_at",             precision: 6
    t.integer   "seq"
  end

  create_table "releases", force: true do |t|
    t.timestamp "start_shows",               precision: 6, null: false
    t.timestamp "end_shows",                 precision: 6, null: false
    t.timestamp "target_date",               precision: 6, null: false
    t.string    "title",         limit: 254,               null: false
    t.string    "url"
    t.text      "body"
    t.integer   "shop_id"
    t.integer   "menu_group_id"
    t.timestamp "created_at",                precision: 6
    t.timestamp "updated_at",                precision: 6
    t.integer   "release_type"
  end

  create_table "shops", force: true do |t|
    t.integer   "old_code"
    t.string    "name",             limit: 62,                                       null: false
    t.string    "furigana",         limit: 62
    t.string    "gname",            limit: 62
    t.string    "postal_code",      limit: 7
    t.string    "address",          limit: 127
    t.string    "phone",            limit: 15
    t.decimal   "lat",                          precision: 11, scale: 8
    t.decimal   "lng",                          precision: 11, scale: 8
    t.integer   "zoom"
    t.integer   "sunday",           limit: 8,                            default: 0, null: false
    t.integer   "monday",           limit: 8,                            default: 0, null: false
    t.integer   "tuesday",          limit: 8,                            default: 0, null: false
    t.integer   "wednesday",        limit: 8,                            default: 0, null: false
    t.integer   "thursday",         limit: 8,                            default: 0, null: false
    t.integer   "friday",           limit: 8,                            default: 0, null: false
    t.integer   "saturday",         limit: 8,                            default: 0, null: false
    t.date      "inauguration"
    t.date      "close"
    t.string    "landmarks",        limit: 127
    t.timestamp "created_at",                   precision: 6
    t.timestamp "updated_at",                   precision: 6
    t.integer   "area_id"
    t.integer   "start_shows"
    t.integer   "seats_at_counter"
    t.integer   "booths"
    t.integer   "seq"
    t.integer   "park_caps"
    t.integer   "truck_park_caps"
    t.integer   "seats_at_booth"
    t.integer   "seats_at_table"
    t.integer   "seats_at_parlor"
    t.integer   "ad_week"
    t.integer   "ad_time"
    t.integer   "wage"
    t.string    "ad_comment",       limit: 190
  end

  create_table "wished_shops", force: true do |t|
    t.integer   "entry_id"
    t.integer   "shop_id"
    t.timestamp "created_at", precision: 6
    t.timestamp "updated_at", precision: 6
  end

end
