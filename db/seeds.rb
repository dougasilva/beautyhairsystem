Cliente.create!([
  {nome: "Janaina Ferreira da Silva", data_nascimento: "1981-03-01", telefone: "1145563658", celular: "11995108729", email: "janaina.janafer@gmail.com", comentarios: "", cep: "06140030", logradouro: "Rua Paulista", numero: "250", compl: "", bairro: "Conceição", cidade: "Osasco", uf: "SP", deleted_at: nil}
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
  {nome: "Maria da Silva", cpf: "14478520144", data_nascimento: "1978-05-20", especialidade_id: 1, telefone: "", celular: "11974802147", email: "", cep: "06150020", logradouro: "Rua Doutor Elcio Cezar Piteri", numero: "20", compl: "", bairro: "Veloso", cidade: "Osasco", uf: "SP"},
  {nome: "Sandra Pereira", cpf: "27784569800", data_nascimento: "1982-07-14", especialidade_id: 1, telefone: "1147852200", celular: "11978541100", email: "", cep: "06150010", logradouro: "Rua Doutor Antonio Flávio França", numero: "74", compl: "Casa 3", bairro: "Veloso", cidade: "Osasco", uf: "SP"},
  {nome: "Silvia Souza", cpf: "36457854100", data_nascimento: "1975-05-08", especialidade_id: 2, telefone: "", celular: "11974102255", email: "", cep: "06350000", logradouro: "Rua Saúde", numero: "796", compl: "", bairro: "Vila Diva", cidade: "Carapicuíba", uf: "SP"},
  {nome: "Carla da Silva", cpf: "47785401200", data_nascimento: "1985-05-06", especialidade_id: nil, telefone: "1145587845", celular: "11978452103", email: "", cep: "06320120", logradouro: "Passagem Arapuã", numero: "500", compl: "Fundos", bairro: "Centro", cidade: "Carapicuíba", uf: "SP"},
  {nome: "Douglas Silva", cpf: "17748106894", data_nascimento: "1980-04-18", especialidade_id: nil, telefone: "1145563658", celular: "11996425797", email: "douglasasilva@gmail.com", cep: "06140040", logradouro: "Rua Pernambucana", numero: "250", compl: "bl 7 ap 22", bairro: "Conceição", cidade: "Osasco", uf: "SP"}
])
Servico.create!([
  {nome: "Corte Masculino", tempo_estimado: 45, preco: "19.9", descricao: "Qualquer tipo", especialidade_id: 1},
  {nome: "Corte Feminino", tempo_estimado: 90, preco: "29.9", descricao: "", especialidade_id: 1},
  {nome: "Manicure", tempo_estimado: 60, preco: "12.9", descricao: "", especialidade_id: 2}
])
Reserva.create!([
  {data: "2017-07-24", hora: "2000-01-01 09:30:00", comentarios: "", cliente_id: 1, servico_id: 2, profissional_id: 2, realizado: false}
])
Usuario.create!([
  {usuario: "maria.silva", password: "123456", password_confirmation: "123456", profissional_id: 1, perfil_id: 3},
  {usuario: "sandra.pereira", password: "123456", password_confirmation: "123456", profissional_id: 2, perfil_id: 3},
  {usuario: "silvia.souza", password: "123456", password_confirmation: "123456", profissional_id: 3, perfil_id: 3},
  {usuario: "carla.silva", password: "123456", password_confirmation: "123456", profissional_id: 4, perfil_id: 2},
  {usuario: "douglas.silva", password: "123456", password_confirmation: "123456", profissional_id: 5, perfil_id: 1}
])
