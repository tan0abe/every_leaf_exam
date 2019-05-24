ActiveRecord::Schema.define(version: 2019_05_24_095922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "priority", null: false
    t.integer "status", default: 0, null: false
    t.integer "deadline", null: false
    t.string "label"
    t.index ["title", "status", "priority"], name: "index_tasks_on_title_and_status_and_priority"
  end
end
