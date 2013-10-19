DynamicDB::Application.routes.draw do
  resources :databases

  root to: 'home#index', as: 'home'
end
