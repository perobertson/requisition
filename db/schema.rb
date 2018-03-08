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

ActiveRecord::Schema.define(version: 20160301011537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "kind",       null: false
    t.index ["kind"], name: "index_abilities_on_kind", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.integer  "type_id",     null: false
    t.string   "name",        null: false
    t.boolean  "for_sale",    null: false
    t.integer  "category_id", null: false
    t.boolean  "rendered",    null: false
    t.index ["category_id"], name: "index_items_on_category_id", using: :btree
    t.index ["for_sale"], name: "index_items_on_for_sale", using: :btree
    t.index ["name"], name: "index_items_on_name", unique: true, using: :btree
    t.index ["type_id"], name: "index_items_on_type_id", unique: true, using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id",   null: false
    t.integer  "item_id",    null: false
    t.integer  "quantity",   null: false
    t.index ["item_id"], name: "index_order_items_on_item_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "user_abilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.integer  "ability_id", null: false
    t.index ["ability_id"], name: "index_user_abilities_on_ability_id", using: :btree
    t.index ["user_id"], name: "index_user_abilities_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "name",                              null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "identities", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "user_abilities", "abilities"
  add_foreign_key "user_abilities", "users"
end
