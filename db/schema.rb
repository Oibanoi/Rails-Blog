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

ActiveRecord::Schema[8.0].define(version: 2025_02_25_163447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "authors", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "bio"
    t.string "website", limit: 255
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }

    t.unique_constraint ["user_id"], name: "authors_user_id_key"
  end

  create_table "blogs", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "content", null: false
    t.timestamptz "published_at"
    t.integer "author_id", null: false
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "content", null: false
    t.integer "user_id", null: false
    t.integer "blog_id", null: false
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "password_digest", limit: 255, null: false
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.string "role", limit: 20, default: "reader", null: false
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }

    t.unique_constraint ["email"], name: "users_email_key"
  end

  add_foreign_key "authors", "users", name: "fk_authors_users", on_delete: :cascade
  add_foreign_key "blogs", "authors", name: "fk_blogs_authors", on_delete: :cascade
  add_foreign_key "comments", "blogs", name: "fk_comments_blogs", on_delete: :cascade
  add_foreign_key "comments", "users", name: "fk_comments_users", on_delete: :cascade
end
