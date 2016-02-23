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

ActiveRecord::Schema.define(version: 20160223195812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.integer  "meal_id"
    t.integer  "resident_id"
    t.integer  "amount",          default: 0,     null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
  end

  add_index "bills", ["meal_id"], name: "index_bills_on_meal_id", using: :btree
  add_index "bills", ["resident_id"], name: "index_bills_on_resident_id", using: :btree

  create_table "communities", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "cap"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "rotation_length"
  end

  add_index "communities", ["name"], name: "index_communities_on_name", unique: true, using: :btree

  create_table "guests", force: :cascade do |t|
    t.integer  "meal_id"
    t.integer  "resident_id"
    t.integer  "multiplier",  default: 2, null: false
    t.string   "name",                    null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "guests", ["meal_id"], name: "index_guests_on_meal_id", using: :btree
  add_index "guests", ["resident_id"], name: "index_guests_on_resident_id", using: :btree

  create_table "meal_residents", force: :cascade do |t|
    t.integer  "meal_id"
    t.integer  "resident_id"
    t.integer  "multiplier",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "meal_residents", ["meal_id", "resident_id"], name: "index_meal_residents_on_meal_id_and_resident_id", using: :btree
  add_index "meal_residents", ["meal_id"], name: "index_meal_residents_on_meal_id", using: :btree
  add_index "meal_residents", ["resident_id"], name: "index_meal_residents_on_resident_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.date     "date",                                  null: false
    t.integer  "cap"
    t.integer  "meal_residents_count",      default: 0, null: false
    t.integer  "guests_count",              default: 0, null: false
    t.integer  "cost",                      default: 0, null: false
    t.integer  "meal_residents_multiplier", default: 0, null: false
    t.integer  "guests_multiplier",         default: 0, null: false
    t.text     "description"
    t.integer  "max"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "reconciliation_id"
  end

  add_index "meals", ["reconciliation_id"], name: "index_meals_on_reconciliation_id", using: :btree

  create_table "reconciliations", force: :cascade do |t|
    t.date     "date",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "residents", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "multiplier", default: 2, null: false
    t.integer  "unit_id"
    t.integer  "bill_costs", default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "residents", ["name"], name: "index_residents_on_name", unique: true, using: :btree
  add_index "residents", ["unit_id"], name: "index_residents_on_unit_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "units", ["name"], name: "index_units_on_name", unique: true, using: :btree

  add_foreign_key "bills", "meals"
  add_foreign_key "bills", "residents"
  add_foreign_key "guests", "meals"
  add_foreign_key "guests", "residents"
  add_foreign_key "meal_residents", "meals"
  add_foreign_key "meal_residents", "residents"
  add_foreign_key "meals", "reconciliations"
  add_foreign_key "residents", "units"
end
