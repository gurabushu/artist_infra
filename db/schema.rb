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

ActiveRecord::Schema[8.1].define(version: 2026_04_10_100000) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "project_id", null: false
    t.text "proposal"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["project_id"], name: "index_applications_on_project_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "billing_subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "current_period_end"
    t.datetime "current_period_start"
    t.string "external_subscription_id"
    t.string "payment_provider"
    t.string "plan_name"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_billing_subscriptions_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "agreed_amount"
    t.integer "artist_id", null: false
    t.integer "client_id", null: false
    t.integer "contract_type"
    t.datetime "created_at", null: false
    t.date "ended_on"
    t.integer "project_id", null: false
    t.string "renewal_cycle"
    t.date "started_on"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_contracts_on_artist_id"
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["project_id"], name: "index_contracts_on_project_id"
  end

  create_table "creator_subscriptions", force: :cascade do |t|
    t.date "canceled_on"
    t.datetime "created_at", null: false
    t.integer "creator_id", null: false
    t.date "started_on"
    t.integer "status"
    t.integer "subscriber_id", null: false
    t.integer "subscription_plan_id", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_creator_subscriptions_on_creator_id"
    t.index ["subscriber_id"], name: "index_creator_subscriptions_on_subscriber_id"
    t.index ["subscription_plan_id"], name: "index_creator_subscriptions_on_subscription_plan_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "target_user_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["target_user_id"], name: "index_favorites_on_target_user_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.integer "recipient_id", null: false
    t.integer "sender_id", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_messages_on_recipient_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "pro_accounts", force: :cascade do |t|
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.text "reason"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_pro_accounts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "area"
    t.string "avatar_url"
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "display_name"
    t.string "genre"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "website_url"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "budget_max"
    t.integer "budget_min"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "project_type"
    t.integer "recruitment_type"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.integer "contract_id", null: false
    t.datetime "created_at", null: false
    t.integer "rating"
    t.integer "reviewee_id", null: false
    t.integer "reviewer_id", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_reviews_on_contract_id"
    t.index ["reviewee_id"], name: "index_reviews_on_reviewee_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "scouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "message"
    t.integer "project_id", null: false
    t.integer "receiver_id", null: false
    t.integer "sender_id", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_scouts_on_project_id"
    t.index ["receiver_id"], name: "index_scouts_on_receiver_id"
    t.index ["sender_id"], name: "index_scouts_on_sender_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.string "cycle"
    t.text "delivery_detail"
    t.text "description"
    t.integer "price"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_subscription_plans_on_user_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "level"
    t.integer "skill_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["skill_id"], name: "index_user_skills_on_skill_id"
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "encrypted_password"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.integer "status"
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "external_url"
    t.boolean "published"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "work_type"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applications", "projects"
  add_foreign_key "applications", "users"
  add_foreign_key "billing_subscriptions", "users"
  add_foreign_key "contracts", "artists"
  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "projects"
  add_foreign_key "creator_subscriptions", "creators"
  add_foreign_key "creator_subscriptions", "subscribers"
  add_foreign_key "creator_subscriptions", "subscription_plans"
  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "users", column: "target_user_id"
  add_foreign_key "messages", "users", column: "recipient_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "pro_accounts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "reviews", "contracts"
  add_foreign_key "reviews", "reviewees"
  add_foreign_key "reviews", "reviewers"
  add_foreign_key "scouts", "projects"
  add_foreign_key "scouts", "receivers"
  add_foreign_key "scouts", "senders"
  add_foreign_key "subscription_plans", "users"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
  add_foreign_key "works", "users"
end
