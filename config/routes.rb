Rails.application.routes.draw do

  root 'sessions#new'
  
  get    'sign_in'   => 'sessions#new'
  post   'sign_in'   => 'sessions#create'
  delete 'sign_out'  => 'sessions#destroy'

  resources :perfis
  resources :profissionais
  resources :especialidades
  resources :servicos
  resources :clientes
  resources :reservas
  resources :usuarios
end
