DynamicDB::Application.routes.draw do
  resources :columns

  resources :tables

  resources :databases

  root to: 'home#index', as: 'home'
end
