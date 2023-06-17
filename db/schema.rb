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

ActiveRecord::Schema.define(version: 20170131233446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "heroes", force: :cascade do |t|
    t.string   "name"
    t.string   "portrait_url"
    t.bigint   "original_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["original_id"], name: "index_heroes_on_original_id", unique: true, using: :btree
  end

  create_table "job_statuses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_job_statuses_on_name_and_user_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_job_statuses_on_user_id", using: :btree
  end

  create_table "live_matches", force: :cascade do |t|
    t.bigint   "original_id"
    t.bigint   "match_id"
    t.integer  "average_mmr"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "finished_at"
  end

  create_table "match_comparisons", force: :cascade do |t|
    t.float    "similarity"
    t.integer  "match_id"
    t.integer  "other_match_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["match_id"], name: "index_match_comparisons_on_match_id", using: :btree
    t.index ["other_match_id"], name: "index_match_comparisons_on_other_match_id", using: :btree
  end

  create_table "matches", force: :cascade do |t|
    t.bigint   "original_id"
    t.datetime "started_at"
    t.integer  "average_mmr"
    t.string   "winner"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.string   "region"
    t.integer  "duration"
    t.index ["original_id", "user_id"], name: "index_matches_on_original_id_and_user_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_matches_on_user_id", using: :btree
  end

  create_table "player_participations", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.integer  "hero_id"
    t.string   "side"
    t.string   "lane"
    t.integer  "slot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "role"
    t.index ["hero_id"], name: "index_player_participations_on_hero_id", using: :btree
    t.index ["match_id"], name: "index_player_participations_on_match_id", using: :btree
    t.index ["player_id"], name: "index_player_participations_on_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.bigint   "original_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["original_id"], name: "index_players_on_original_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.bigint   "original_id"
    t.string   "auth_token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["original_id"], name: "index_users_on_original_id", unique: true, using: :btree
  end

  add_foreign_key "job_statuses", "users"
  add_foreign_key "match_comparisons", "matches"
  add_foreign_key "match_comparisons", "matches", column: "other_match_id"
  add_foreign_key "matches", "users"
  add_foreign_key "player_participations", "heroes"
  add_foreign_key "player_participations", "matches"
  add_foreign_key "player_participations", "players"
end
