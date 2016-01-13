json.array!(@especialidades) do |especialidade|
  json.extract! especialidade, :id, :nome
  json.url especialidade_url(especialidade, format: :json)
end
