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

ActiveRecord::Schema.define(version: 20160131201418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.string   "name"
    t.integer  "multiplier",                  null: false
    t.boolean  "is_guest",    default: false, null: false
    t.integer  "resident_id"
    t.integer  "meal_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["meal_id"], name: "index_attendances_on_meal_id", using: :btree
    t.index ["resident_id"], name: "index_attendances_on_resident_id", using: :btree
  end

  create_table "bills", force: :cascade do |t|
    t.integer  "meal_id"
    t.integer  "resident_id"
    t.integer  "amount",      default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["meal_id"], name: "index_bills_on_meal_id", using: :btree
    t.index ["resident_id"], name: "index_bills_on_resident_id", using: :btree
  end

  create_table "communities", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "cap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.date     "date",              null: false
    t.integer  "community_id"
    t.integer  "cap"
    t.integer  "attendances_count"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["community_id"], name: "index_meals_on_community_id", using: :btree
  end

  create_table "residents", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "multiplier", default: 2, null: false
    t.integer  "unit_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["unit_id"], name: "index_residents_on_unit_id", using: :btree
  end

  create_table "units", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attendances", "meals"
  add_foreign_key "attendances", "residents"
  add_foreign_key "bills", "meals"
  add_foreign_key "bills", "residents"
  add_foreign_key "meals", "communities"
  add_foreign_key "residents", "units"
end
