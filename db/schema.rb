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

ActiveRecord::Schema.define(version: 20170322023236) do

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

  create_table "perfis", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profissionais", force: :cascade do |t|
    t.string   "nome"
    t.string   "cpf"
    t.date     "data_nascimento"
    t.integer  "especialidade_id"
    t.string   "telefone"
    t.string   "celular"
    t.string   "email"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "profissionais", ["especialidade_id"], name: "index_profissionais_on_especialidade_id"

  create_table "reservas", force: :cascade do |t|
    t.date     "data"
    t.time     "hora"
    t.text     "comentarios"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "cliente_id"
    t.integer  "servico_id"
    t.integer  "profissional_id"
    t.boolean  "realizado"
  end

  add_index "reservas", ["cliente_id"], name: "index_reservas_on_cliente_id"
  add_index "reservas", ["profissional_id"], name: "index_reservas_on_profissional_id"
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

  create_table "useres", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "useres", ["email"], name: "index_useres_on_email", unique: true
  add_index "useres", ["reset_password_token"], name: "index_useres_on_reset_password_token", unique: true

  create_table "usuarios", force: :cascade do |t|
    t.boolean  "admin"
    t.integer  "profissional_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["profissional_id"], name: "index_usuarios_on_profissional_id"
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end
