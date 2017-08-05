Cliente.create!([
  {nome: "Janaina Aparecida Ferreira da Silva", data_nascimento: "1981-03-01", telefone: "1145563658", celular: "11995108729", email: "janaina.janafer@gmail.com", comentarios: ""}
])
Especialidade.create!([
  {nome: "Cabeleireiro", comentarios: nil},
  {nome: "Manicure", comentarios: nil}
])
Perfil.create!([
  {nome: "Administrador"},
  {nome: "Operador"},
  {nome: "Profissional"}
])
Profissional.create!([
  {nome: "Maria da Silva", cpf: "14478520144", data_nascimento: "1978-05-20", especialidade_id: 1, telefone: "", celular: "11974802147", email: ""},
  {nome: "Sandra Pereira", cpf: "27784569800", data_nascimento: "1982-07-14", especialidade_id: 1, telefone: "1147852200", celular: "11978541100", email: ""},
  {nome: "Silvia Souza", cpf: "36457854100", data_nascimento: "1975-05-08", especialidade_id: 2, telefone: "", celular: "11974102255", email: ""},
  {nome: "Carla da Silva", cpf: "47785401200", data_nascimento: "1985-05-06", especialidade_id: nil, telefone: "1145587845", celular: "11978452103", email: ""},
  {nome: "Douglas Silva", cpf: "17748106894", data_nascimento: "1980-04-18", especialidade_id: nil, telefone: "1145563658", celular: "11996425797", email: "douglasasilva@gmail.com"}
])
Servico.create!([
  {nome: "Corte Masculino", tempo_estimado: 45, preco: "19.9", descricao: "Qualquer tipo", especialidade_id: 1},
  {nome: "Corte Feminino", tempo_estimado: 90, preco: "29.9", descricao: "", especialidade_id: 1},
  {nome: "Manicure", tempo_estimado: 60, preco: "12.9", descricao: "", especialidade_id: 2}
])
Usuario.create!([
  {usuario: "maria.silva", password: "123456", password_confirmation: "123456", profissional_id: 1, perfil_id: 3},
  {usuario: "sandra.pereira", password: "123456", password_confirmation: "123456", profissional_id: 2, perfil_id: 3},
  {usuario: "silvia.souza", password: "123456", password_confirmation: "123456", profissional_id: 3, perfil_id: 3},
  {usuario: "carla.silva", password: "123456", password_confirmation: "123456", profissional_id: 4, perfil_id: 2},
  {usuario: "douglas.silva", password: "123456", password_confirmation: "123456", profissional_id: 5, perfil_id: 1}
])
Reserva.create!([
  {data: "2017-08-05", hora: "2000-01-01 09:30:00", comentarios: "", cliente_id: 1, servico_id: 2, profissional_id: 2, realizado: false}
])
