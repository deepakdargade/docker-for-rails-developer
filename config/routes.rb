Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index'
  root 'welcome#index'
end
