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

ActiveRecord::Schema.define(version: 20160102183914) do

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.string "hex_value"
  end

  add_index "colors", ["name"], name: "index_colors_on_name"

  create_table "parrots", force: :cascade do |t|
    t.string   "name"
    t.integer  "color_id"
    t.string   "sex"
    t.integer  "age",        default: 0
    t.boolean  "tribal",     default: false
    t.integer  "mother_id"
    t.integer  "father_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "parrots", ["color_id"], name: "index_parrots_on_color_id"

end
