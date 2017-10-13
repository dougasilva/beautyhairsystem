require 'rails_helper'
feature 'Usuario cria novo cliente com ' do

  before :each do
    perfil1 =  create(:perfil, nome: 'Administrador')
    especialidade1 = create(:especialidade, nome: 'Gerente')
    profissional1 =  create(:profissional, nome:'Douglas Silva', cpf:'17748106894',
                           data_nascimento: '20/02/1975',
                           especialidade: especialidade1, telefone: '',
                           celular: '11976108755', email: '')

    usuario1 = create(:usuario, profissional: profissional1, perfil: perfil1,
                      usuario:'douglas.silva', password: '1234567',
                      password_confirmation: '1234567')

    visit sign_in_path
    fill_in 'Usuário:', with: 'douglas.silva'
    fill_in 'Senha:', with: '1234567'
    click_button 'Login'
  end

  scenario 'sucesso' do
    visit new_cliente_path
    fill_in 'Nome', with: 'Janaina Ferreira'
    fill_in 'Nascimento', with: '01/03/1981'
    fill_in 'Telefone', with: '1145563655'
    fill_in 'Celular', with: '11995108755'
    fill_in 'Email', with: 'janaina@ig.com'
    fill_in 'Cep', with: '06140040'
    fill_in 'Logradouro', with: 'Rua Pernambucana'
    fill_in 'Bairro', with: 'Conceição'
    fill_in 'Cidade', with: 'Osasco'
    fill_in 'UF', with: 'SP'
    fill_in 'Número', with: '333'
    fill_in 'Complemento', with: 'Fundos'
    click_on 'Salvar'

    expect(page).to have_content 'Janaina Ferreira'
    expect(page).to have_content '01/03/1981'
    expect(page).to have_content '(11) 4556-3655'
    expect(page).to have_content '(11) 99510-8755'
    expect(page).to have_content 'janaina@ig.com'
    expect(page).to have_content '06140-040'
    expect(page).to have_content '333'
    expect(page).to have_content 'Fundos'
    expect(page).to have_content 'Cliente criado com sucesso.'
  end

  scenario 'falha' do
    visit new_cliente_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    cliente = create(:cliente)
    cliente1 = create(:cliente, nome: 'Debora Silva',
                                data_nascimento: '19/07/1977',
                                email: 'debora@uol.com', telefone: '',
                                celular: '11974234737')
    visit clientes_path

    expect(page).to have_content cliente.nome
    expect(page).to have_content cliente1.nome
  end

  scenario 'sucesso e edita informações' do
    cliente = create(:cliente)
    visit edit_cliente_path(cliente)

    fill_in 'Nome', with: 'Janaina Ferreira'
    fill_in 'Nascimento', with: '01/03/1981'
    fill_in 'Telefone', with: ''
    fill_in 'Celular', with: '11995108799'
    fill_in 'Email', with: 'janaina@ig.com.br'
    fill_in 'Comentários', with: 'Cliente de teste.'
    click_on 'Salvar'

    expect(page).to have_content 'Janaina Ferreira'
    expect(page).to have_content '01/03/1981'
    expect(page).to have_content ''
    expect(page).to have_content '(11) 99510-8799'
    expect(page).to have_content 'janaina@ig.com.br'
    expect(page).to have_content 'Cliente de teste.'
    expect(page).to have_content 'Cliente atualizado com sucesso.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    cliente = create(:cliente)
    visit edit_cliente_path(cliente)

    fill_in 'Nome', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui cliente' do
    create(:cliente)

    visit clientes_path

    click_on 'Excluir'

    expect(page).to have_content 'Cliente excluído com sucesso.'
  end
end
