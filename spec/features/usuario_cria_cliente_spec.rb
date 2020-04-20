require 'rails_helper'
require 'capybara/poltergeist'

feature 'Usuario cria novo cliente com ' do

  let(:usuario) { create(:usuario) } 
  
  before :each do
    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'

    @cliente = create(:cliente)
  end

  scenario 'sucesso' do
    visit new_cliente_path
    fill_in 'Nome', with:  Faker::Name.name 
    fill_in 'Nascimento', with:  Faker::Date.birthday(min_age: 18, max_age: 40) 
    fill_in 'Telefone', with:  Faker::Base.numerify('##########') 
    fill_in 'Celular', with:  Faker::Base.numerify('###########') 
    fill_in 'Email', with:  Faker::Internet.email 
    fill_in 'Cep', with:  Faker::Base.numerify('########') 
    page.execute_script("$('#logradouro').removeAttr('readonly')")
    fill_in 'Logradouro', with:  Faker::Address.street_name 
    page.execute_script("$('#bairro').removeAttr('readonly')")
    fill_in 'Bairro', with:  Faker::Address.community 
    page.execute_script("$('#cidade').removeAttr('readonly')")
    fill_in 'Cidade', with:  Faker::Address.city 
    page.execute_script("$('#uf').removeAttr('readonly')")
    fill_in 'UF', with:  Faker::Address.state_abbr 
    fill_in 'Número', with:  Faker::Address.building_number 
    fill_in 'Complemento', with:  Faker::Address.secondary_address 
    click_on 'Salvar'

    expect(page).to have_content 'Cliente criado.'
  end

  scenario 'falha' do
    visit new_cliente_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todos os cadastrados' do
    cliente1 = create(:cliente)
    
    visit clientes_path

    expect(page).to have_content @cliente.nome
    expect(page).to have_content cliente1.nome
  end

  scenario 'sucesso e edita informações' do
    cliente1 = create(:cliente)
    visit edit_cliente_path(cliente1)

    nome =  Faker::Name.name 
    fill_in 'Nome', with: nome
    
    click_on 'Salvar'

    expect(page).to have_content nome
    expect(page).to have_content 'Cliente atualizado.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    cliente1 = create(:cliente)
    visit edit_cliente_path(cliente1)

    fill_in 'Nome', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui cliente', js: true do

    visit clientes_path

    click_on 'Excluir'

    expect(page).to have_content 'Cliente excluído.'
  end
end
