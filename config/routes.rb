DynamicDB::Application.routes.draw do
  root to: 'home#index', as: 'home'

  resources :databases

  # TODO: This should get moved within :databases.
  resources :tables

  # TODO: These should get moved within :tables.
  resources :columns
  resources :records
end
