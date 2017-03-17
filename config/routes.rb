Rails.application.routes.draw do
  resources :perfis
  resources :profissionais
  resources :especialidades
  resources :servicos
  resources :clientes
  resources :reservas
end
