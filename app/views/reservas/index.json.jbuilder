json.array!(@reservas) do |reserva|
  json.extract! reserva, :id, :cliente, :servico, :profissional, :preco, :data, :hora, :comentarios
  json.url reserva_url(reserva, format: :json)
end
