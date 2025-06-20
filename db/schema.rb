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

ActiveRecord::Schema[8.0].define(version: 2025_06_20_173658) do
  create_table "project_yarns", force: :cascade do |t|
    t.integer "yarn_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_yarns_on_project_id"
    t.index ["yarn_id"], name: "index_project_yarns_on_yarn_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "pattern_name"
    t.string "pattern_source"
    t.string "designer"
    t.string "craft"
    t.string "tool_size"
    t.integer "yardage"
    t.string "weight"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yarns", force: :cascade do |t|
    t.string "brand_name"
    t.string "colorway"
    t.string "fiber"
    t.string "weight"
    t.integer "yardage"
    t.integer "quantity"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_yarns_on_user_id"
  end

  add_foreign_key "project_yarns", "projects"
  add_foreign_key "project_yarns", "yarns"
  add_foreign_key "projects", "users"
  add_foreign_key "yarns", "users"
end
