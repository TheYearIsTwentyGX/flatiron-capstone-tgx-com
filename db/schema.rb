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

ActiveRecord::Schema[7.0].define(version: 2023_08_28_222808) do
  create_table "access_profiles", force: :cascade do |t|
    t.string "Friendly_Name"
    t.string "Department"
    t.string "Title"
    t.boolean "IsAdmin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.string "Report_Name"
    t.string "Discipline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "Phone"
    t.string "Fax"
    t.string "Address1"
    t.string "Address2"
    t.string "City"
    t.string "State"
    t.integer "Zip"
  end

  create_table "facility_accesses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "facility_id", null: false
    t.integer "user_id", null: false
    t.integer "profile"
    t.index ["facility_id"], name: "index_facility_accesses_on_facility_id"
    t.index ["user_id"], name: "index_facility_accesses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "User_Name"
    t.string "password_digest"
    t.string "Full_Name"
    t.date "Access_Until"
    t.string "Email_Address"
    t.string "Phone"
    t.integer "Extension"
    t.string "Credentials"
  end

  add_foreign_key "facility_accesses", "facilities"
  add_foreign_key "facility_accesses", "users"
end
