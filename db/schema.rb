# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100612201335) do

  create_table "graph_lines", :force => true do |t|
    t.string   "name"
    t.integer  "sortindex"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "graph_id"
    t.integer  "source_id"
  end

  create_table "graphs", :force => true do |t|
    t.string   "name"
    t.string   "stack_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samples", :force => true do |t|
    t.integer  "source_id"
    t.float    "value"
    t.datetime "sampled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secrets", :force => true do |t|
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
