require 'rails_helper'
feature 'Usuario cria reserva com ' do
  scenario 'sucesso' do
    cliente = create(:cliente)
    servico = create(:servico)
    visit new_reserva_path
    select cliente.nome, from: 'Cliente:'
    select servico.nome, from: 'Serviço:'
    fill_in 'Profissional:', with: 'Sandra Souza'
    fill_in 'Preço:', with: 29.90
    fill_in 'Data:', with: '11/01/2016'
    select '10:00', from: 'Hora:'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Cadastrar'

    expect(page).to have_content cliente.nome
    expect(page).to have_content servico.nome
    expect(page).to have_content 'Sandra Souza'
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

  scenario 'sucesso e lista todas as cadastradas' do
    reserva = create(:reserva)
    cliente1 = create(:cliente, nome: 'Debora Silva',
                     data_nascimento: '19/07/1977', email: 'debora@uol.com',
                     telefone: '', celular: '11974234737')
    reserva1 = create(:reserva, cliente: cliente1)
    visit reservas_path

    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva1.cliente.nome
  end

  scenario 'sucesso e edita informações' do
    reserva = create(:reserva)
    visit edit_reserva_path(reserva)

    select reserva.cliente.nome, from: 'Cliente:'
    select reserva.servico.nome, from: 'Serviço:'
    fill_in 'Profissional:', with: 'Sandra Souza'
    fill_in 'Preço:', with: 29.90
    fill_in 'Data:', with: '12/01/2016'
    select '11:00', from: 'Hora:'
    fill_in 'Comentários:', with: 'Reserva de teste.'
    click_on 'Cadastrar'

    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva.servico.nome
    expect(page).to have_content 'Sandra Souza'
    expect(page).to have_content 29.90
    expect(page).to have_content '12/01/2016'
    expect(page).to have_content '11:00'
    expect(page).to have_content 'Reserva de teste.'
    expect(page).to have_content 'Reserva atualizada.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    reserva = create(:reserva)
    visit edit_reserva_path(reserva)

    select reserva.cliente.nome, from: 'Cliente:'
    select reserva.servico.nome, from: 'Serviço:'
    fill_in 'Data:', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content 'Please review the problems below'
  end

  scenario 'sucesso e exclui reserva' do
    reserva = create(:reserva)

    visit reservas_path

    click_on 'Excluir'

    expect(page).to have_content 'Reserva excluída.'
  end
end
