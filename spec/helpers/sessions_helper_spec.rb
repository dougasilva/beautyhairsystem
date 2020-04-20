require 'rails_helper'

describe 'login', type: :feature do
  let(:usuario) { create(:usuario) }
  
  it 'signs users in' do
    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: usuario.password
    click_button 'Login'

    have_current_path(root_path)
    expect(page).to have_content('Reservas')
  end

  it 'signs users in with error' do
    
    visit sign_in_path
    fill_in 'Usuário:', with: usuario.usuario
    fill_in 'Senha:', with: ''
    click_button 'Login'

    expect(page).to have_content('Login')
  end

  describe 'logout', type: :feature do
    it 'signs users in' do
      visit sign_in_path
      fill_in 'Usuário:', with: usuario.usuario
      fill_in 'Senha:', with: usuario.password
      click_button 'Login'
      expect(page).to have_link('Sair', href: sign_out_path)
      expect(page).to have_content('Reservas')

      click_link 'Sair'

      expect(page).to have_content('Login')
    end
  end
end
