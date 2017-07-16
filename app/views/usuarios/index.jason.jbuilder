json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :usuario, :profissional, :password,
                :password_confirmation, :perfil
  json.url usuario_url(usuario, format: :json)
end
