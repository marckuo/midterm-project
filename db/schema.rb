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

ActiveRecord::Schema.define(version: 20160420170447) do

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at"
    t.string   "address"
    t.integer  "player_one_id"
    t.integer  "player_two_id"
    t.integer  "sport_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "phone"
    t.datetime "birthday"
    t.string   "profile_pic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", null: false
    t.string   "session_token"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token"
  add_index "users", ["username"], name: "index_users_on_username"

end
