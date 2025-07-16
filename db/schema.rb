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

ActiveRecord::Schema[8.0].define(version: 2025_07_16_024117) do
  create_table "administrators", force: :cascade do |t|
    t.string "username"
    t.string "hash_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.text "answer_text"
    t.integer "answer_alternative"
    t.integer "form_id", null: false
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_answers_on_form_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forms", force: :cascade do |t|
    t.boolean "active_status"
    t.integer "receiver_role"
    t.integer "subject_id", null: false
    t.integer "template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_forms_on_subject_id"
    t.index ["template_id"], name: "index_forms_on_template_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.integer "question_type"
    t.integer "template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_questions_on_template_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "class_name"
    t.string "schedule"
    t.string "semester"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_subjects_on_course_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_forms", force: :cascade do |t|
    t.integer "status"
    t.integer "user_id", null: false
    t.integer "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_user_forms_on_form_id"
    t.index ["user_id"], name: "index_user_forms_on_user_id"
  end

  create_table "user_subjects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_user_subjects_on_subject_id"
    t.index ["user_id"], name: "index_user_subjects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "hash_password"
    t.integer "role"
    t.integer "academic_background"
    t.string "student_course"
    t.string "student_enrolment"
    t.string "professor_departament"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.datetime "password_defined_at"
    t.string "password_token"
  end

  add_foreign_key "answers", "forms"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "forms", "subjects"
  add_foreign_key "forms", "templates"
  add_foreign_key "questions", "templates"
  add_foreign_key "subjects", "courses"
  add_foreign_key "user_forms", "forms"
  add_foreign_key "user_forms", "users"
  add_foreign_key "user_subjects", "subjects"
  add_foreign_key "user_subjects", "users"
end
