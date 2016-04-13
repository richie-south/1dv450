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

ActiveRecord::Schema.define(version: 20160329172600) do

  create_table "applikations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "app_name",   limit: 20, null: false
    t.string   "appkey",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "applikations", ["user_id"], name: "index_applikations_on_user_id"

  create_table "creators", force: :cascade do |t|
    t.string   "name",            limit: 20, null: false
    t.string   "password_digest"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "positions", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "address"
    t.integer  "toilet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "positions", ["toilet_id"], name: "index_positions_on_toilet_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["creator_id"], name: "index_tags_on_creator_id"

  create_table "tags_toilets", id: false, force: :cascade do |t|
    t.integer "toilet_id"
    t.integer "tag_id"
  end

  add_index "tags_toilets", ["tag_id"], name: "index_tags_toilets_on_tag_id"
  add_index "tags_toilets", ["toilet_id"], name: "index_tags_toilets_on_toilet_id"

  create_table "toilets", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "creator_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "toilets", ["creator_id"], name: "index_toilets_on_creator_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_name",       limit: 20,                 null: false
    t.string   "password_digest",                            null: false
    t.boolean  "isAdmin",                    default: false, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end
