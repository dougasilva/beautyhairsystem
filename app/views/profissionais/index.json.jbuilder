json.array!(@profissionais) do |profissional|
  json.extract! profissional, :id, :nome, :cpf, :data_nascimento,
                :especialidade_id, :telefone, :celular, :email
  json.url profissional_url(profissional, format: :json)
end
