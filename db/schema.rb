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

ActiveRecord::Schema[7.1].define(version: 2025_11_05_150656) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "reference"
  end

  create_table "cards", force: :cascade do |t|
    t.string "subject"
    t.string "quote"
    t.string "comment"
    t.string "edition"
    t.string "city"
    t.date "year"
    t.date "internet_access_date"
    t.string "internet_access_link"
    t.bigint "user_id", null: false
    t.bigint "resource_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_cards_on_author_id"
    t.index ["resource_id"], name: "index_cards_on_resource_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplines_authors", force: :cascade do |t|
    t.bigint "discipline_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_disciplines_authors_on_author_id"
    t.index ["discipline_id"], name: "index_disciplines_authors_on_discipline_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "starred_cards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_starred_cards_on_card_id"
    t.index ["user_id"], name: "index_starred_cards_on_user_id"
  end

  create_table "subtopics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subtopics_topics", force: :cascade do |t|
    t.bigint "subtopic_id", null: false
    t.bigint "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subtopic_id"], name: "index_subtopics_topics_on_subtopic_id"
    t.index ["topic_id"], name: "index_subtopics_topics_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics_authors", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_topics_authors_on_author_id"
    t.index ["topic_id"], name: "index_topics_authors_on_topic_id"
  end

  create_table "topics_disciplines", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "discipline_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discipline_id"], name: "index_topics_disciplines_on_discipline_id"
    t.index ["topic_id"], name: "index_topics_disciplines_on_topic_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "cards", "authors"
  add_foreign_key "cards", "sources", column: "resource_id"
  add_foreign_key "cards", "users"
  add_foreign_key "disciplines_authors", "authors"
  add_foreign_key "disciplines_authors", "disciplines"
  add_foreign_key "starred_cards", "cards"
  add_foreign_key "starred_cards", "users"
  add_foreign_key "subtopics_topics", "subtopics"
  add_foreign_key "subtopics_topics", "topics"
  add_foreign_key "topics_authors", "authors"
  add_foreign_key "topics_authors", "topics"
  add_foreign_key "topics_disciplines", "disciplines"
  add_foreign_key "topics_disciplines", "topics"
end
