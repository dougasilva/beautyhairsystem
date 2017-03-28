json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :admin, :profissional_id
  json.url usuario_url(usuario, format: :json)
end
