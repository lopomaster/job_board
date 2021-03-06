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

ActiveRecord::Schema.define(version: 2019_06_14_203215) do

  create_table "candidates", force: :cascade do |t|
    t.string "profession"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_adverts", force: :cascade do |t|
    t.integer "job_advert_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_advert_id"], name: "index_job_adverts_on_company_id"
  end

  create_table "job_subscriptions", force: :cascade do |t|
    t.integer "candidate_id", null: false
    t.integer "job_advert_id", null: false
    t.integer "subscription_status_cd", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_job_subscriptions_on_candidate_id"
    t.index ["job_advert_id", "candidate_id"], name: "index_job_subscriptions_on_job_advert_id_and_candidate_id", unique: true
    t.index ["job_advert_id"], name: "index_job_subscriptions_on_job_advert_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "profile_type", null: false
    t.integer "profile_id", null: false
    t.string "email", default: "", null: false
    t.string "username", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_type", "profile_id"], name: "index_users_on_profile_type_and_profile_id"
  end

end
