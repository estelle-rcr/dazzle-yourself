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

<<<<<<< HEAD

ActiveRecord::Schema.define(version: 2020_03_16_114245) do
=======
ActiveRecord::Schema.define(version: 2020_03_16_144952) do
>>>>>>> 19094ce5203aec8c8dff7575b504dd35dfb8d14d


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"


  create_table "attendances", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "attendee_id"
    t.string "stripe_customer_id"
    t.string "state"
    t.integer "price_attendee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendee_id"], name: "index_attendances_on_attendee_id"
    t.index ["project_id"], name: "index_attendances_on_project_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "title"
    t.integer "price_attendee"
    t.integer "price_owner"
    t.integer "number_of_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "package_id"
    t.bigint "owner_id"
    t.string "title"
    t.string "short_description"
    t.text "long_description"
    t.string "state"
    t.datetime "submit_date"
    t.datetime "publication_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "attendees_goal", default: 5
    t.integer "attendees_subscribed", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["package_id"], name: "index_projects_on_package_id"
  end

  create_table "skill_setups", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "skill_id"
    t.boolean "primary"
    t.index ["skill_id"], name: "index_skill_setups_on_skill_id"
    t.index ["user_id"], name: "index_skill_setups_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end


end
