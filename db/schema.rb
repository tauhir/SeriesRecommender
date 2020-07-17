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

ActiveRecord::Schema.define(version: 2020_04_04_170352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "current_query"
    t.integer "results"
    t.integer "pages"
    t.string "query_list", default: [], array: true
  end

  create_table "series_lists", force: :cascade do |t|
    t.string "api_id"
    t.string "name"
    t.string "language"
    t.string "external_series", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "search_id", null: false
    t.integer "list_type"
    t.index ["search_id"], name: "index_series_lists_on_search_id"
  end

  add_foreign_key "series_lists", "searches"
end
