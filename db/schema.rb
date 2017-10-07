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

ActiveRecord::Schema.define(version: 20171007201123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "excel_files", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "description"
    t.string   "xl"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "galleries", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "borrower_last_name"
    t.string   "loan_num"
    t.string   "loan_program"
    t.decimal  "note_rate",                                   precision: 4,  scale: 3
    t.decimal  "loan_amt",                                    precision: 10, scale: 2
    t.string   "funding_source"
    t.string   "investor_loan_num"
    t.decimal  "loan_trade_total_buy_price",                  precision: 6,  scale: 3
    t.decimal  "loan_trade_total_sell_price",                 precision: 6,  scale: 3
    t.decimal  "ltv",                                         precision: 6,  scale: 3
    t.string   "investor"
    t.decimal  "bottom_ratio",                                precision: 9,  scale: 3
    t.decimal  "combined_ltv",                                precision: 9,  scale: 3
    t.integer  "fico"
    t.string   "rate_lock_sell_investor_name"
    t.string   "investor_status"
    t.string   "lock_commitment"
    t.string   "lock_status"
    t.datetime "lock_request_time"
    t.date     "lock_expiration_date"
    t.date     "rate_lock_sell_side_lock_date"
    t.date     "rate_lock_sell_side_lock_expires_date"
    t.date     "closing_date"
    t.decimal  "closing_disclosure_minus_closing_costs",      precision: 9,  scale: 2
    t.date     "shipping_actual_shipping_date"
    t.date     "est_closing_date"
    t.date     "closing_disclosure_received_date"
    t.string   "last_finished_milestone"
    t.string   "borrower_first_name"
    t.integer  "days_until_lock_expires"
    t.decimal  "rate_lock_sell_side_gain_loss_percent",       precision: 5,  scale: 3
    t.decimal  "rate_lock_sell_side_base_price_total_adjust", precision: 5,  scale: 3
    t.string   "impounds_waived"
    t.decimal  "rate_lock_sell_side_total_sell_price",        precision: 7,  scale: 3
    t.decimal  "rate_lock_sell_side_srp_paid_out",            precision: 5,  scale: 3
    t.datetime "created_at",                                                                                     null: false
    t.datetime "updated_at",                                                                                     null: false
    t.string   "us_state",                                                             default: "MN"
    t.string   "property_type",                                                        default: "single-family"
  end

  add_index "loans", ["loan_num"], name: "index_loans_on_loan_num", unique: true, using: :btree

  create_table "paintings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "gallery_id"
    t.string   "name"
    t.string   "image"
    t.string   "remote_image_url"
    t.string   "xl"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wells_fargo_price_sheets", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "description"
    t.string   "thefile"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "json"
  end

  create_table "wells_fargo_srp_sheets", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "description"
    t.string   "thefile"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "json"
  end

end
