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

ActiveRecord::Schema[7.2].define(version: 2024_09_14_054306) do
  create_table "addresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "address_cd"
    t.integer "prefecture_cd"
    t.integer "city_cd"
    t.integer "town_cd"
    t.string "postal_code"
    t.boolean "business_flag"
    t.boolean "abolished_flag"
    t.string "prefecture"
    t.string "prefecture_kana"
    t.string "city"
    t.string "city_kana"
    t.string "town"
    t.string "town_kana"
    t.string "town_supplement"
    t.string "kyoto_street"
    t.string "chome"
    t.string "chome_kana"
    t.string "supplement"
    t.string "business_name"
    t.string "business_name_kana"
    t.string "business_address"
    t.integer "new_address_cd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
