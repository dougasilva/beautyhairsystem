json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :nome, :data_nascimento, :telefone, :celular,
                :email, :comentarios, :cep, :numero, :compl
  json.url cliente_url(cliente, format: :json)
end
