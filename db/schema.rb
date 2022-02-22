# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_20_104031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "allowed_notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "new_opportunity_available", default: false
    t.boolean "project_bid_accepted", default: false
    t.boolean "timesheet_rejected", default: false
    t.boolean "new_timesheet_submitted", default: false
    t.boolean "new_invoice_submitted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "new_freelancer_signed_up", default: true
    t.index ["user_id"], name: "index_allowed_notifications_on_user_id"
  end

  create_table "client_details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name"
    t.boolean "all_checked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_customer_id"
    t.index ["user_id"], name: "index_client_details_on_user_id"
  end

  create_table "freelancer_details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "contract_signed_date"
    t.datetime "form_1099_signed_date"
    t.datetime "background_check_passed"
    t.string "candidate_id"
    t.string "report_id"
    t.string "status"
    t.string "ip_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "resume_url"
    t.string "sign_up_code"
    t.boolean "sign_up_code_entered", default: false
    t.boolean "interview_scheduled", default: false
    t.boolean "qualified", default: false
    t.integer "work_hours_per_week"
    t.integer "desired_hourly_rate"
    t.string "connected_account_id"
    t.string "public_id"
    t.string "file_format"
    t.integer "pages"
    t.index ["user_id"], name: "index_freelancer_details_on_user_id"
  end

  create_table "freelancer_skills", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["skill_id"], name: "index_freelancer_skills_on_skill_id"
    t.index ["user_id", "skill_id"], name: "add_unique_columns_freelancer_skills", unique: true
    t.index ["user_id"], name: "index_freelancer_skills_on_user_id"
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "queue_name"
    t.integer "priority"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.string "item"
    t.decimal "qty", precision: 6, scale: 2, null: false
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "time_entry_id"
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    t.index ["time_entry_id"], name: "index_invoice_items_on_time_entry_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.date "invoice_date"
    t.integer "invoice_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invoice_ID"
    t.bigint "project_id"
    t.string "error_message"
    t.index ["project_id"], name: "index_invoices_on_project_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "payment_type"
    t.decimal "net_amount", precision: 7, scale: 2, null: false
    t.decimal "full_amount", precision: 7, scale: 2, null: false
    t.decimal "stripe_fee", precision: 7, scale: 2, null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "available_on"
  end

  create_table "project_bids", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "compensation"
    t.integer "bids_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_project_bids_on_project_id"
    t.index ["user_id", "project_id"], name: "add_unique_columns_project", unique: true
    t.index ["user_id"], name: "index_project_bids_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "project_duration"
    t.integer "project_status"
    t.integer "invoicing_schedule"
    t.integer "client_type_of_billing"
    t.decimal "client_payment_amount", precision: 7, scale: 2, null: false
    t.decimal "freelancer_payment_amount", precision: 7, scale: 2, null: false
    t.bigint "freelancer_detail_id"
    t.bigint "client_detail_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "automated_invoicing", default: false
    t.string "error_message"
    t.index ["client_detail_id"], name: "index_projects_on_client_detail_id"
    t.index ["freelancer_detail_id"], name: "index_projects_on_freelancer_detail_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "category"
    t.string "sub_category"
    t.string "skill"
    t.boolean "enable", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.string "task"
    t.decimal "hours", precision: 6, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "timesheet_id"
    t.boolean "invoiced", default: false
    t.string "customer"
    t.index ["timesheet_id"], name: "index_time_entries_on_timesheet_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.integer "timesheet_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "timesheet_date"
    t.text "notes"
    t.bigint "project_id"
    t.bigint "freelancer_id"
    t.index ["project_id"], name: "index_timesheets_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "image"
    t.string "email", null: false
    t.integer "role", default: 1
    t.boolean "is_blocked", default: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_legacy_user", default: false
    t.boolean "is_password_set", default: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "allowed_notifications", "users"
  add_foreign_key "client_details", "users"
  add_foreign_key "freelancer_details", "users"
  add_foreign_key "freelancer_skills", "skills"
  add_foreign_key "freelancer_skills", "users"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "time_entries"
  add_foreign_key "project_bids", "users"
  add_foreign_key "projects", "client_details"
  add_foreign_key "projects", "freelancer_details"
end
