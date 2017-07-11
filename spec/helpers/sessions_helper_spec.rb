require 'rails_helper'

describe 'login', :type => :feature do
 it 'signs users in' do
  usuario = create(:usuario)
   #visit new_sessions_path
   visit sign_in_path
   fill_in 'Usuário:', with: 'sandra.souza'
   fill_in 'Senha:', with: '123456'
   click_button 'Login'

   expect(page).to have_content('Reservas')
 end

 describe 'logout', :type => :feature do
  it 'signs users in' do
   usuario = create(:usuario)
    #visit new_sessions_path
    visit sign_in_path
    fill_in 'Usuário:', with: 'sandra.souza'
    fill_in 'Senha:', with: '123456'
    click_button 'Login'

    expect(page).to have_link('Log out', href: sign_out_path)
    expect(page).to have_content('Reservas')


    click_link 'Log out'

    expect(page).to have_content('Login')
   end
 end

end
