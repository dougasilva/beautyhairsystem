require 'rails_helper'
feature 'Usuario cria reserva com ' do
  scenario 'sucesso' do
    especialidade = create(:especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    visit new_reserva_path
    select cliente.nome, from: 'Cliente:'
    select servico.nome, from: 'Serviço:'
    select profissional.nome, from: 'Profissional:'
    fill_in 'Data:', with: '11/01/2016'
    select '10:00', from: 'Hora:'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Cadastrar'

    expect(page).to have_content cliente.nome
    expect(page).to have_content servico.nome
    expect(page).to have_content profissional.nome
    expect(page).to have_content 29.90
    expect(page).to have_content '11/01/2016'
    expect(page).to have_content '10:00'
    expect(page).to have_content 'Reserva de teste.'
    expect(page).to have_content 'Reserva criada.'
  end

  scenario 'falha' do
    visit new_reserva_path
    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e edita informações' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional)
    visit edit_reserva_path(reserva)

    select cliente.nome, from: 'Cliente:'
    select servico.nome, from: 'Serviço:'
    fill_in 'Data:', with: '12/01/2016'
    select '11:00', from: 'Hora:'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Cadastrar'

    expect(page).to have_content cliente.nome
    expect(page).to have_content servico.nome
    expect(page).to have_content profissional.nome
    expect(page).to have_content 29.90
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

    select cliente.nome, from: 'Cliente:'
    select servico.nome, from: 'Serviço:'
    fill_in 'Data:', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario ' consulta proximo mês' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               data: '10/04/2017', profissional: profissional)

    visit reservas_path

    click_on ">"

     expect(page).to have_content reserva.data.month

  end

  scenario ' excluir reserva' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional)
    visit reserva_path(reserva)

    click_on 'Excluir'

    expect(page).to have_content 'Reserva excluída.'

  end
end
