Rails.application.routes.draw do
  resources :users
  get 'welcome', to: 'welcome#index'
  root 'welcome#index'
end
