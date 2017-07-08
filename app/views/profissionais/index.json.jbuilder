json.array!(@profissionais) do |profissional|
  json.extract! profissional, :id, :nome, :cpf, :data_nascimento,
                :especialidade_id, :telefone, :celular, :email, :perfil_id
  json.url profissional_url(profissional, format: :json)
end
