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

ActiveRecord::Schema.define(version: 20150419145309) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "artist_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "key",             limit: 255
    t.text     "description",     limit: 65535
    t.integer  "artist_group_id", limit: 4,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "official_url",    limit: 255
    t.string   "image_path",      limit: 255
    t.integer  "status",          limit: 4,     default: 0
    t.datetime "published_at"
  end

  create_table "devices", force: :cascade do |t|
    t.string   "key",        limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "media_type",       limit: 4,     default: 1, null: false
    t.text     "description",      limit: 65535
    t.integer  "artist_id",        limit: 4,                 null: false
    t.integer  "price",            limit: 4
    t.integer  "billing_method",   limit: 4,     default: 3, null: false
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_path",       limit: 255
    t.string   "youtube_id",       limit: 255
    t.integer  "status",           limit: 4,     default: 0
    t.datetime "published_at"
    t.string   "vimeo_id",         limit: 255
    t.string   "apple_product_id", limit: 255
  end

  create_table "purchased_items", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.integer  "item_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reward_histories", force: :cascade do |t|
    t.integer  "device_id",   limit: 4
    t.integer  "cid",         limit: 4
    t.string   "cname",       limit: 255
    t.integer  "carrier",     limit: 4
    t.datetime "click_date"
    t.datetime "action_date"
    t.integer  "amount",      limit: 4
    t.integer  "commission",  limit: 4
    t.string   "aff_id",      limit: 255
    t.integer  "point",       limit: 4
    t.integer  "pid",         limit: 4
    t.integer  "item_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "reward_histories", ["cid", "device_id", "action_date", "pid"], name: "conversion", unique: true, using: :btree

  create_table "staffs", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                   limit: 4,                null: false
    t.integer  "artist_group_id",        limit: 4
  end

  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true, using: :btree
  add_index "staffs", ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true, using: :btree

end
