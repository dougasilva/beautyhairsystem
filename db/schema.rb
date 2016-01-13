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

ActiveRecord::Schema.define(version: 20160113150340) do

  create_table "clientes", force: :cascade do |t|
    t.string   "nome"
    t.date     "data_nascimento"
    t.string   "telefone"
    t.string   "celular"
    t.string   "email"
    t.text     "comentarios"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "especialidades", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservas", force: :cascade do |t|
    t.string   "profissional"
    t.decimal  "preco"
    t.date     "data"
    t.time     "hora"
    t.text     "comentarios"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "cliente_id"
    t.integer  "servico_id"
  end

  add_index "reservas", ["cliente_id"], name: "index_reservas_on_cliente_id"
  add_index "reservas", ["servico_id"], name: "index_reservas_on_servico_id"

  create_table "servicos", force: :cascade do |t|
    t.string   "nome"
    t.integer  "tempo_estimado"
    t.decimal  "preco"
    t.text     "descricao"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "especialidade_id"
  end

  add_index "servicos", ["especialidade_id"], name: "index_servicos_on_especialidade_id"

end
