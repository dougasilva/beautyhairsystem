require 'rails_helper'
feature 'Usuario cria especialidade com ' do

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
    visit new_especialidade_path
    fill_in 'Nome:', with: 'Cabeleireiro'
    click_on 'Salvar'

    expect(page).to have_content 'Cabeleireiro'
    expect(page).to have_content 'Especialidade criada.'
  end

  scenario 'falha' do
    visit new_especialidade_path
    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e lista todas os cadastradas' do
    especialidade = create(:especialidade)
    especialidade1 = create(:especialidade, nome: 'Manicure')
    visit especialidades_path

    expect(page).to have_content especialidade.nome
    expect(page).to have_content especialidade1.nome
  end

  scenario 'sucesso e edita informações' do
    especialidade = create(:especialidade)
    visit edit_especialidade_path(especialidade)

    fill_in 'Nome:', with: 'Cabeleireira'
    click_on 'Salvar'

    expect(page).to have_content 'Cabeleireira'
    expect(page).to have_content 'Especialidade atualizada.'
  end

  scenario 'sucesso e atualiza com dados inválidos' do
    especialidade = create(:especialidade)
    visit edit_especialidade_path(especialidade)

    fill_in 'Nome:', with: ''

    click_on 'Salvar'

    expect(page).to have_content 'Alguns erros foram encontrados'
  end

  scenario 'sucesso e exclui' do
    visit especialidades_path

    click_on 'Excluir'

    expect(page).to have_content 'Especialidade excluída.'
  end
end
