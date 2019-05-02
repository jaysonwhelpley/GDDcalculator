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

ActiveRecord::Schema.define(version: 2019_05_01_143842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.date "the_date"
    t.float "temp_max_c"
    t.float "temp_min_c"
    t.float "temp_max_f"
    t.float "temp_min_f"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raw_infos", force: :cascade do |t|
    t.integer "info_type"
    t.string "api_call"
    t.jsonb "entry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sentinels", force: :cascade do |t|
    t.string "title"
    t.float "gdd"
    t.float "target_gdd"
    t.float "temp_lowest_f"
    t.float "temp_lowest_c"
    t.bigint "lowest_day_id"
    t.float "target_c"
    t.float "target_f"
    t.bigint "target_day_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lowest_day_id"], name: "index_sentinels_on_lowest_day_id"
    t.index ["target_day_id"], name: "index_sentinels_on_target_day_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weather_records", force: :cascade do |t|
    t.float "temp_f"
    t.float "temp_c"
    t.bigint "day_id"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_weather_records_on_day_id"
  end

  add_foreign_key "sentinels", "days", column: "lowest_day_id"
  add_foreign_key "sentinels", "days", column: "target_day_id"
end
