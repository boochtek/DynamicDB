DynamicDB::Application.routes.draw do
  root to: 'home#index', as: 'home'

  resources :databases do
    resources :tables
  end

  resources :tables do
    resources :columns
  end

  resources :columns
  resources :records
end
