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

ActiveRecord::Schema.define(version: 20160731202446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "score",      default: 0
  end

  create_table "words", force: :cascade do |t|
    t.string   "lang_code1"
    t.string   "text1"
    t.string   "lang_code2"
    t.string   "text2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "pos"
    t.integer  "user_id"
  end

  add_index "words", ["lang_code1", "lang_code2", "text1", "text2"], name: "index_words_on_lang_code1_and_lang_code2_and_text1_and_text2", unique: true, using: :btree
  add_index "words", ["user_id"], name: "index_words_on_user_id", using: :btree

end
