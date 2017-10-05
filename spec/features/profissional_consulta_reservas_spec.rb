require 'rails_helper'
feature 'Profissional consulta reservas com ' do

  before :each do
    perfil =  create(:perfil, nome: 'Administrador')
    especialidade1 = create(:especialidade, nome: 'Gerente')
    profissional1 =  create(:profissional, nome:'Douglas Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')

    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil,
                      usuario:'douglas.silva', password: '1234567',
                      password_confirmation: '1234567')

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '1234567'
    click_button 'Login'

  end

  scenario 'sucesso' do

    usuario = create(:usuario)
    especialidade3 = create(:especialidade, nome: 'Massagista')
    profissional = create(:profissional, nome: 'Maria', especialidade: especialidade3)
    cliente = create(:cliente)
    servico = create(:servico, nome: 'Massagem', especialidade: especialidade3)
    visit new_reserva_path
    select cliente.nome, from: 'Cliente:'
    select servico.nome, from: 'Serviço:'
    select profissional.nome, from: 'Profissional:'
    fill_in 'Data:', with: '11/01/2016'
    fill_in 'Hora:', with: '10:00'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Salvar'

    #Segunda reserva
    especialidade2 = create(:especialidade, nome: 'Manicure')
    servico2 = create(:servico, nome: 'Pedicure', especialidade: especialidade2)
    perfil2 = create(:perfil, nome: 'Operador')
    profissional2 = create(:profissional, nome: 'Debora Cristina',
                                          especialidade: especialidade2,
                                          data_nascimento: '19/07/1977',
                                          email: 'debora@uol.com', telefone: '',
                                          celular: '11974234737',
                                          cpf: '17748106894')
    usuario2 = create(:usuario, profissional: profissional2, perfil: perfil2,
                      usuario:'debora.cristina', password: '1234567',
                      password_confirmation: '1234567')
    cliente2 = create(:cliente, nome: 'Amanda Nanes',
                                data_nascimento: '15/04/1985',
                                email: 'amanda@uol.com', telefone: '',
                                celular: '11984234737')
    reserva2 = create(:reserva, cliente: cliente2, servico: servico2,
                                data: 1.days.from_now,
                                profissional: profissional2)

    click_link 'Sair'

    visit sign_in_path
    fill_in 'Usuário:', with: 'sandra.souza'
    fill_in 'Senha:', with: '123456'
    click_button 'Login'

    click_link 1.days.from_now.strftime('%d/%m/%Y')

  end

  scenario ' consulta proximo mês' do
    usuario = create(:usuario)
    especialidade3 = create(:especialidade, nome: 'Massagista')
    profissional = create(:profissional, nome: 'Maria', especialidade: especialidade3)
    cliente = create(:cliente)
    servico = create(:servico, nome: 'Massagem', especialidade: especialidade3)
    visit new_reserva_path
    select cliente.nome, from: 'Cliente:'
    select servico.nome, from: 'Serviço:'
    select profissional.nome, from: 'Profissional:'
    fill_in 'Data:', with: '11/01/2016'
    fill_in 'Hora:', with: '10:00'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Salvar'

    #Segunda reserva
    especialidade2 = create(:especialidade, nome: 'Manicure')
    servico2 = create(:servico, nome: 'Pedicure', especialidade: especialidade2)
    perfil2 = create(:perfil, nome: 'Operador')
    profissional2 = create(:profissional, nome: 'Debora Cristina',
                                          especialidade: especialidade2,
                                          data_nascimento: '19/07/1977',
                                          email: 'debora@uol.com', telefone: '',
                                          celular: '11974234737',
                                          cpf: '17748106894')
    usuario2 = create(:usuario, profissional: profissional2, perfil: perfil2,
                      usuario:'debora.cristina', password: '1234567',
                      password_confirmation: '1234567')
    cliente2 = create(:cliente, nome: 'Amanda Nanes',
                                data_nascimento: '15/04/1985',
                                email: 'amanda@uol.com', telefone: '',
                                celular: '11984234737')
    reserva2 = create(:reserva, cliente: cliente2, servico: servico2,
                                data: 1.days.from_now,
                                profissional: profissional2)

    click_link 'Sair'

    visit sign_in_path
    fill_in 'Usuário:', with: 'sandra.souza'
    fill_in 'Senha:', with: '123456'
    click_button 'Login'

    visit reservas_path

    click_on ">"

     #expect(page).to have_content reserva.data.month

  end


end
