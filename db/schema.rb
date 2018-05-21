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

ActiveRecord::Schema.define(version: 20180521040905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deposit_workers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "deposit_id"
    t.integer "worker_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "user_income", precision: 25, scale: 12
    t.index ["deposit_id"], name: "index_deposit_workers_on_deposit_id"
    t.index ["user_id"], name: "index_deposit_workers_on_user_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.bigint "worker_id"
    t.decimal "income", precision: 25, scale: 12, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "bitcoin_price", precision: 18, scale: 8, default: "0.0"
    t.date "date"
    t.index ["worker_id"], name: "index_deposits_on_worker_id"
  end

  create_table "user_workers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "worker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "worker_count", default: 0, null: false
    t.index ["user_id"], name: "index_user_workers_on_user_id"
    t.index ["worker_id"], name: "index_user_workers_on_worker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "name", null: false
    t.string "country", null: false
    t.string "company_name", null: false
    t.decimal "profit_share", precision: 4, scale: 1, null: false
    t.string "currency", default: "USD", null: false
    t.string "language", default: "en", null: false
    t.integer "zip"
    t.decimal "net_income", precision: 25, scale: 12, default: "0.0"
    t.string "street_name"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mining_address"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "workers", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description"
    t.decimal "electricity_cost", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "net_income", precision: 25, scale: 12, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_workers", default: 0, null: false
    t.integer "currency_id"
    t.index ["title"], name: "index_workers_on_title", unique: true
  end

  add_foreign_key "user_workers", "users"
  add_foreign_key "user_workers", "workers"
end
