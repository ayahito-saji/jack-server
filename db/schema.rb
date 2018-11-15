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

ActiveRecord::Schema.define(version: 20181016025151) do

  create_table "events", force: :cascade do |t|
    t.string "event_id"
    t.string "title"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "place"
    t.text "description"
    t.boolean "need_attendance"
    t.boolean "done_attendance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_events", force: :cascade do |t|
    t.integer "member_id"
    t.integer "event_id"
    t.integer "attendance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_member_events_on_event_id"
    t.index ["member_id"], name: "index_member_events_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "member_id", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.date "birthday", null: false
    t.boolean "is_graduate", default: false, null: false
    t.date "enroll_date", null: false
    t.integer "repeat_years", default: 0, null: false
    t.string "icon_url", default: "", null: false
    t.text "profile", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "slack_id", default: "", null: false
    t.integer "school_id"
    t.integer "faculty_id"
    t.integer "department_id"
    t.boolean "admin", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true
    t.index ["department_id"], name: "index_members_on_department_id"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["faculty_id"], name: "index_members_on_faculty_id"
    t.index ["member_id"], name: "index_members_on_member_id", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_members_on_school_id"
  end

end
