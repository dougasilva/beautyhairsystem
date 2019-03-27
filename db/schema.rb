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

ActiveRecord::Schema.define(version: 2017_11_11_145834) do

  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.date "data_nascimento"
    t.string "telefone"
    t.string "celular"
    t.string "email"
    t.text "comentarios"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cep"
    t.string "logradouro"
    t.string "numero"
    t.string "compl"
    t.string "bairro"
    t.string "cidade"
    t.string "uf"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_clientes_on_deleted_at"
  end

  create_table "especialidades", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "comentarios"
  end

  create_table "perfis", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profissionais", force: :cascade do |t|
    t.string "nome"
    t.string "cpf"
    t.date "data_nascimento"
    t.integer "especialidade_id"
    t.string "telefone"
    t.string "celular"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cep"
    t.string "logradouro"
    t.string "numero"
    t.string "compl"
    t.string "bairro"
    t.string "cidade"
    t.string "uf"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_profissionais_on_deleted_at"
    t.index ["especialidade_id"], name: "index_profissionais_on_especialidade_id"
  end

  create_table "reservas", force: :cascade do |t|
    t.date "data"
    t.time "hora"
    t.text "comentarios"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cliente_id"
    t.integer "servico_id"
    t.integer "profissional_id"
    t.boolean "realizado"
    t.boolean "pago"
    t.decimal "preco"
    t.index ["cliente_id"], name: "index_reservas_on_cliente_id"
    t.index ["profissional_id"], name: "index_reservas_on_profissional_id"
    t.index ["servico_id"], name: "index_reservas_on_servico_id"
  end

  create_table "servicos", force: :cascade do |t|
    t.string "nome"
    t.integer "tempo_estimado"
    t.decimal "preco"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "especialidade_id"
    t.index ["especialidade_id"], name: "index_servicos_on_especialidade_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "usuario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "profissional_id"
    t.integer "perfil_id"
    t.index ["perfil_id"], name: "index_usuarios_on_perfil_id"
    t.index ["profissional_id"], name: "index_usuarios_on_profissional_id"
  end

end
