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

ActiveRecord::Schema.define(version: 20160821053225) do

  create_table "foods", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.float    "calories",           limit: 24
    t.float    "totalFat",           limit: 24
    t.float    "totalCarbohydrate",  limit: 24
    t.float    "protein",            limit: 24
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.float    "quantity",           limit: 24
    t.float    "saturatedFat",       limit: 24
    t.float    "polyunsaturatedFat", limit: 24
    t.float    "monounsaturatedFat", limit: 24
    t.float    "cholesterol",        limit: 24
    t.float    "dietaryFiber",       limit: 24
    t.float    "solubleFiber",       limit: 24
    t.float    "sodium",             limit: 24
    t.float    "potassium",          limit: 24
    t.float    "calcium",            limit: 24
    t.float    "magnesium",          limit: 24
    t.float    "iron",               limit: 24
    t.float    "zinc",               limit: 24
    t.float    "copper",             limit: 24
    t.float    "manganese",          limit: 24
    t.float    "iodine",             limit: 24
    t.float    "selenium",           limit: 24
    t.float    "chromium",           limit: 24
    t.float    "molybdenum",         limit: 24
    t.float    "vitaminA",           limit: 24
    t.float    "vitaminD",           limit: 24
    t.float    "vitaminE",           limit: 24
    t.float    "vitaminK",           limit: 24
    t.float    "thiamin",            limit: 24
    t.float    "riboflavin",         limit: 24
    t.float    "niacin",             limit: 24
    t.float    "vitaminB6",          limit: 24
    t.float    "vitaminB12",         limit: 24
    t.float    "folate",             limit: 24
    t.float    "vitaminB5",          limit: 24
    t.float    "biotin",             limit: 24
    t.float    "vitaminC",           limit: 24
    t.string   "category",           limit: 255
  end

  create_table "nutrients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "quantity",   limit: 24
    t.string   "unit",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
