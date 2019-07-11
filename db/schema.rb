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

ActiveRecord::Schema.define(version: 2019_07_11_164457) do

  create_table "connects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_connects_on_group_id"
    t.index ["user_id"], name: "index_connects_on_user_id"
  end

  create_table "groupmessages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groupmessages_on_group_id"
    t.index ["user_id"], name: "index_groupmessages_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "memberships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "talk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["talk_id"], name: "index_memberships_on_talk_id"
    t.index ["user_id", "talk_id"], name: "index_memberships_on_user_id_and_talk_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.bigint "talk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["talk_id"], name: "index_messages_on_talk_id"
    t.index ["updated_at", "talk_id"], name: "index_messages_on_updated_at_and_talk_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "talks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["updated_at"], name: "index_talks_on_updated_at"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "comment"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "connects", "groups"
  add_foreign_key "connects", "users"
  add_foreign_key "groupmessages", "groups"
  add_foreign_key "groupmessages", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "memberships", "talks"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "talks"
  add_foreign_key "messages", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "tags", "users"
end
