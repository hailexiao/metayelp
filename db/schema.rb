
ActiveRecord::Schema.define(version: 20150928211402) do
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "downvotes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
  end

  add_index "downvotes", ["user_id", "review_id"], name: "index_downvotes_on_user_id_and_review_id", unique: true, using: :btree

  create_table "reviews", force: :cascade do |t|
    t.text     "body",       null: false
    t.string   "rating",     null: false
    t.integer  "user_id",    null: false
    t.integer  "yelper_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "upvotes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
  end

  add_index "upvotes", ["user_id", "review_id"], name: "index_upvotes_on_user_id_and_review_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_photo"
    t.string   "role",                   default: "member", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "yelpers", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "number_of_reviews"
    t.string   "image_url"
    t.string   "uid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "yelpers", ["uid"], name: "index_yelpers_on_uid", unique: true, using: :btree

end
