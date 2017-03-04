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

ActiveRecord::Schema.define(version: 20170302145209) do

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "token"
    t.index ["token"], name: "index_customers_on_token", unique: true, using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "ticket_id"
    t.text     "text",       limit: 65535
    t.index ["ticket_id"], name: "index_messages_on_ticket_id", using: :btree
  end

  create_table "support_agents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",           default: false, null: false
    t.string   "password_digest"
    t.string   "token"
    t.index ["token"], name: "index_support_agents_on_token", unique: true, using: :btree
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "customer_id"
    t.integer  "support_agent_id"
    t.text     "description",      limit: 65535
    t.string   "status"
    t.string   "title"
    t.index ["customer_id"], name: "index_tickets_on_customer_id", using: :btree
    t.index ["support_agent_id"], name: "index_tickets_on_support_agent_id", using: :btree
  end

  add_foreign_key "messages", "tickets"
  add_foreign_key "tickets", "customers"
  add_foreign_key "tickets", "support_agents"
end
