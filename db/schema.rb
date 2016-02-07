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

ActiveRecord::Schema.define(version: 20160207202307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "media", force: :cascade do |t|
    t.string   "title"
    t.string   "state"
    t.integer  "workflow_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "metadata", force: :cascade do |t|
    t.integer  "medium_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transcodes", force: :cascade do |t|
    t.string   "title"
    t.string   "general_option"
    t.string   "infile_option"
    t.string   "outfile_option"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "workflows", force: :cascade do |t|
    t.string   "title"
    t.string   "kind"
    t.boolean  "active"
    t.string   "in_folder"
    t.string   "out_folder"
    t.integer  "transcode_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
