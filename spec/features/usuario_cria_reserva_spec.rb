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
    fill_in 'Preço:', with: 29.90
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

  scenario 'sucesso e lista todas as cadastradas' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    profissional1 = create(:profissional, nome: 'Maria Santos',
                                          cpf: '45525001477',
                                          data_nascimento: '10/10/1977',
                                          especialidade: especialidade,
                                          telefone: '1156789900',
                                          celular: '11987541200')
    cliente = create(:cliente)
    cliente1 = create(:cliente, nome: 'Debora Silva',
                                data_nascimento: '19/07/1977',
                                email: 'debora@uol.com', telefone: '',
                                celular: '11974234737')
    servico = create(:servico, especialidade: especialidade)
    servico1 = create(:servico, nome: 'Escova', especialidade: especialidade,
                                preco: 19.90, tempo_estimado: 45)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional)
    reserva1 = create(:reserva, cliente: cliente1, servico: servico1,
                                profissional: profissional1)
    visit reservas_path

    expect(page).to have_content reserva.cliente.nome
    expect(page).to have_content reserva1.cliente.nome
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
    fill_in 'Preço:', with: 29.90
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

  scenario 'sucesso e exclui reserva' do
    especialidade = create(:especialidade)
    profissional = create(:profissional, especialidade: especialidade)
    cliente = create(:cliente)
    servico = create(:servico, especialidade: especialidade)
    reserva = create(:reserva, cliente: cliente, servico: servico,
                               profissional: profissional)

    visit reservas_path

    click_on 'Excluir'

    expect(page).to have_content 'Reserva excluída.'
  end
end
