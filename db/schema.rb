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

ActiveRecord::Schema.define(version: 2021_06_25_122329) do

  create_table "bookmarks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "memo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memo_id"], name: "index_bookmarks_on_memo_id"
    t.index ["user_id", "memo_id"], name: "index_bookmarks_on_user_id_and_memo_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "under_category_ids", default: "/"
    t.index ["name", "user_id"], name: "index_categories_on_name_and_user_id", unique: true
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "impressions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "impressionable_type"
    t.string "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: { params: 255 }
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: { message: 255 }
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "memo_tag_relations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "memo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memo_id"], name: "index_memo_tag_relations_on_memo_id"
    t.index ["tag_id", "memo_id"], name: "index_memo_tag_relations_on_tag_id_and_memo_id", unique: true
    t.index ["tag_id"], name: "index_memo_tag_relations_on_tag_id"
  end

  create_table "memos", id: { type: :string, limit: 20 }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.integer "public_status", default: 0, null: false
    t.index ["category_id"], name: "index_memos_on_category_id"
    t.index ["public_status"], name: "index_memos_on_public_status"
    t.index ["status"], name: "index_memos_on_status"
    t.index ["user_id"], name: "index_memos_on_user_id"
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "access_token", null: false
    t.string "avatar"
    t.text "introduction"
    t.index ["access_token"], name: "index_users_on_access_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "bookmarks", "memos"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "memo_tag_relations", "memos"
  add_foreign_key "memo_tag_relations", "tags"
  add_foreign_key "memos", "categories"
  add_foreign_key "memos", "users"
end
