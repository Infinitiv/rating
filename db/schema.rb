# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130913180558) do

  create_table "academic_titles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chairs", force: true do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "clinic"
  end

  add_index "chairs", ["faculty_id"], name: "index_chairs_on_faculty_id"

  create_table "degrees", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "chair_id"
    t.integer  "post_id"
    t.integer  "degree_id"
    t.integer  "academic_title_id"
    t.boolean  "head"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["academic_title_id"], name: "index_employees_on_academic_title_id"
  add_index "employees", ["chair_id"], name: "index_employees_on_chair_id"
  add_index "employees", ["degree_id"], name: "index_employees_on_degree_id"
  add_index "employees", ["post_id"], name: "index_employees_on_post_id"

  create_table "faculties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.boolean  "administrator"
    t.boolean  "editor"
    t.boolean  "viewer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", force: true do |t|
    t.float    "qualification"
    t.float    "learning"
    t.float    "science"
    t.float    "clinic"
    t.float    "social"
    t.integer  "year"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "points", ["employee_id"], name: "index_points_on_employee_id"

  create_table "posts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["group_id"], name: "index_users_on_group_id"

end
