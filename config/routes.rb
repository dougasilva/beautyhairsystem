Rails.application.routes.draw do
  devise_for :usuarios
  devise_for :useres
  resources :usuarios
  resources :perfis
  resources :profissionais
  resources :especialidades
  resources :servicos
  resources :clientes
  resources :reservas
end
