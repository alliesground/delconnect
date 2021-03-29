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

ActiveRecord::Schema.define(version: 2021_03_29_043459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "speakers", force: :cascade do |t|
    t.string "name"
  end

  create_table "talks", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "event_id", null: false
    t.bigint "speaker_id", null: false
    t.index ["event_id"], name: "index_talks_on_event_id"
    t.index ["speaker_id"], name: "index_talks_on_speaker_id"
  end

  add_foreign_key "talks", "events"
  add_foreign_key "talks", "speakers"
end
