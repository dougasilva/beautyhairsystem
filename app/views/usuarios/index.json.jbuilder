json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :nome, :profissional, :password,
                :password_confirmation
  json.url usuario_url(usuario, format: :json)
end
