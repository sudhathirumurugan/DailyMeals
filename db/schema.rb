# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_12_140625) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "daily_meal_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.boolean "snack"
    t.boolean "dinner"
    t.integer "chapati_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "meal_type"
    t.index ["user_id"], name: "index_daily_meal_records_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "comments_for_dinner"
    t.string "comments_for_snack"
    t.float "rating_for_dinner"
    t.float "rating_for_snack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "daily_meal_record_id"
    t.index ["daily_meal_record_id"], name: "index_feedbacks_on_daily_meal_record_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "meal_preference_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.boolean "enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meal_preference_settings_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_snacks"
    t.integer "total_dinners"
    t.integer "total_chapatis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "type"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_meal_records", "users"
  add_foreign_key "feedbacks", "daily_meal_records"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "meal_preference_settings", "users"
end
