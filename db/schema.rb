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

ActiveRecord::Schema[7.1].define(version: 2024_05_07_180243) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_events", force: :cascade do |t|
    t.string "type", null: false
    t.integer "application_id", null: false
    t.json "data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "application_id"], name: "index_application_events_on_type_and_application_id"
  end

  create_table "applications", force: :cascade do |t|
    t.integer "job_id", null: false
    t.string "candidate_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_events", force: :cascade do |t|
    t.string "type", null: false
    t.integer "job_id", null: false
    t.json "data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "job_id"], name: "index_job_events_on_type_and_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
