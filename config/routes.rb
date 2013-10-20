DynamicDB::Application.routes.draw do
  root to: 'home#index', as: 'home'

  resources :databases do
    resources :tables
  end

  resources :tables do
    resources :columns
  end

  # TODO: These should get moved within :tables.
  resources :columns
  resources :records
end
