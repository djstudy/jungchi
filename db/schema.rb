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

ActiveRecord::Schema.define(version: 20150908121601) do

  create_table "representatives", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "party"
    t.string   "area"
    t.integer  "combo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "popularity"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vote_infos", force: :cascade do |t|
    t.integer  "vote_id"
    t.string   "info_type"
    t.integer  "sequence"
    t.text     "content"
    t.integer  "speaker_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "content_plus"
    t.string   "content_title"
  end

  create_table "vote_results", force: :cascade do |t|
    t.integer  "representative_id"
    t.integer  "user_id"
    t.integer  "vote_id"
    t.string   "result"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "votes", force: :cascade do |t|
    t.date     "voted_date"
    t.string   "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "vote_info_url"
  end

end
