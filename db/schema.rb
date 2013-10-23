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

ActiveRecord::Schema.define(version: 20131017081349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chores", force: true do |t|
    t.string   "title",        null: false
    t.text     "description",  null: false
    t.integer  "point_value",  null: false
    t.integer  "household_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "household_invites", force: true do |t|
    t.integer  "household_id", null: false
    t.string   "token",        null: false
    t.string   "email",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "household_invites", ["email", "household_id"], name: "index_household_invites_on_email_and_household_id", unique: true
  add_index "household_invites", ["household_id"], name: "index_household_invites_on_household_id"

  create_table "household_users", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "household_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "household_users", ["user_id", "household_id"], name: "index_household_users_on_user_id_and_household_id", unique: true

  create_table "households", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", force: true do |t|
    t.string   "title",                        null: false
    t.text     "description",                  null: false
    t.integer  "point_value",                  null: false
    t.boolean  "approved",     default: false, null: false
    t.integer  "household_id",                 null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.time     "performed_at", null: false
    t.integer  "chore_id",     null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "display_name",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "votes", force: true do |t|
    t.boolean  "approve",       null: false
    t.integer  "user_id",       null: false
    t.integer  "suggestion_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id"
  end

  add_index "votes", ["household_id"], name: "index_votes_on_household_id"
  add_index "votes", ["user_id", "suggestion_id"], name: "index_votes_on_user_id_and_suggestion_id", unique: true

end
