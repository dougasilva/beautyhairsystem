json.array!(@servicos) do |servico|
  json.extract! servico, :id, :nome, :especialidade, :tempo_estimado, :preco,
                :descricao
  json.url servico_url(servico, format: :json)
end
