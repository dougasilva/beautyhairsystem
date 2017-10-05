require 'rails_helper'
feature 'Usuario cria reserva com ' do

  before :each do
    perfil =  create(:perfil)
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
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    visit new_reserva_path
    select cliente.nome, from: 'Cliente:'
    select servico.nome, from: 'Serviço:'
    select profissional.nome, from: 'Profissional:'
    fill_in 'Data:', with: '11/01/2016'
    fill_in 'Hora:', with: '10:00'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Salvar'

    expect(page).to have_content cliente.nome
    expect(page).to have_content servico.nome
    expect(page).to have_content profissional.nome
    expect(page).to have_content 'R$ 29,90'
    expect(page).to have_content '11/01/2016'
    expect(page).to have_content '10:00'
    expect(page).to have_content 'Reserva de teste.'
    expect(page).to have_content 'Reserva criada.'
  end

  scenario 'falha' do
    visit new_reserva_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e edita informações' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional, data: :today)
    visit edit_reserva_path(reserva)

    select servico.nome, from: 'Serviço:'
    fill_in 'Data:', with: '12/01/2016'
    fill_in 'Hora:', with: '11:00'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Salvar'

    expect(page).to have_content cliente.nome
    expect(page).to have_content servico.nome
    expect(page).to have_content profissional.nome
    expect(page).to have_content 'R$ 29,90'
    expect(page).to have_content '12/01/2016'
    expect(page).to have_content '11:00'
    expect(page).to have_content 'Reserva de teste.'
    expect(page).to have_content 'Reserva atualizada.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional)
    visit edit_reserva_path(reserva)

    select servico.nome, from: 'Serviço:'
    fill_in 'Data:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario ' consulta proximo mês' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               data: 30.days.from_now, profissional: profissional)

    visit reservas_path

    click_on ">"

     expect(page).to have_content reserva.data.month

  end

  scenario ' sucesso e exclui' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional,
                               data: 1.days.from_now, hora: '10:00')

    visit reserva_path(reserva)

    click_on 'Excluir'

    expect(page).to have_content 'Reserva excluída.'

  end

  scenario ' sucesso e marca como realizada' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional, data: :today)
    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '10:00'
    page.check 'Realizado'
    click_on 'Salvar'

    expect(page).to have_content 'Sim'
    expect(page).to have_content 'Reserva atualizada.'

  end

  scenario ' sucesso, marca como realizada e mostra todas realizadas' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional, data: :today,
                               hora: '10:00')
    reserva2 = create(:reserva, cliente: cliente, servico: servico,
                                profissional: profissional, data: :today,
                                hora: '11:00')

    visit edit_reserva_path(reserva)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '10:00'
    page.check 'Realizado'
    click_on 'Salvar'

    expect(page).to have_content 'Reserva atualizada.'

    visit edit_reserva_path(reserva2)

    fill_in 'Data:', with: 0.days.from_now
    fill_in 'Hora:', with: '11:00'
    page.check 'Realizado'
    click_on 'Salvar'

    expect(page).to have_content 'Reserva atualizada.'

    visit reservas_realizadas_path

    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva2.cliente.nome

  end
end
