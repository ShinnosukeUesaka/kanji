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

ActiveRecord::Schema.define(version: 2020_05_26_123303) do

  create_table "datedevs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "today"
  end

  create_table "kanjichar_questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "kanjichar_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kanjichar_id"], name: "index_kanjichar_questions_on_kanjichar_id"
    t.index ["question_id"], name: "index_kanjichar_questions_on_question_id"
  end

  create_table "kanjichars", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "kanji"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.boolean "active"
    t.integer "category"
    t.boolean "learning_mode"
    t.integer "learning_mode_n"
    t.integer "e_factor"
    t.boolean "show"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "due_date"
    t.date "previous_due_date"
    t.integer "answer"
    t.integer "interval_after_learning_mode"
    t.index ["question_id"], name: "index_progresses_on_question_id"
    t.index ["user_id", "question_id"], name: "index_progresses_on_user_id_and_question_id", unique: true
    t.index ["user_id"], name: "index_progresses_on_user_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "level"
    t.integer "category"
    t.string "kanji"
    t.string "yomi"
    t.string "meaning"
    t.string "ex_top"
    t.string "ex_bottom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kanji", "ex_top", "ex_bottom"], name: "index_questions_on_kanji_and_ex_top_and_ex_bottom", unique: true
  end

  create_table "settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "init_e_factor"
    t.boolean "auto_init_e_factor"
    t.string "learning_mode_intervals"
    t.integer "max_new_questions"
    t.integer "max_total_questions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "studysets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.date "study_began_on"
    t.boolean "active"
    t.integer "level"
    t.boolean "kaki_active"
    t.boolean "yomi_active"
    t.boolean "yoji_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "level"], name: "index_studysets_on_user_id_and_level", unique: true
    t.index ["user_id"], name: "index_studysets_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "age"
    t.date "kanken_day"
    t.integer "kanken_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "active_today"
    t.integer "usertype"
  end

  add_foreign_key "kanjichar_questions", "kanjichars"
  add_foreign_key "kanjichar_questions", "questions"
  add_foreign_key "progresses", "questions"
  add_foreign_key "progresses", "users"
  add_foreign_key "settings", "users"
  add_foreign_key "studysets", "users"
end
