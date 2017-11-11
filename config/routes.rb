Rails.application.routes.draw do

  get 'usuarios/new'
  get    'sign_in'   => 'sessions#new'
  post   'sign_in'   => 'sessions#create'
  delete 'sign_out'  => 'sessions#destroy'

  get 'reservas/por_data' => 'reservas#por_data'
  get 'reservas/realizadas' => 'reservas#realizadas'
  get 'reservas/pagas' => 'reservas#pagas'

  resources :perfis
  resources :profissionais
  resources :especialidades
  resources :servicos
  resources :clientes
  resources :reservas
  resources :usuarios

  root 'sessions#new'
end
