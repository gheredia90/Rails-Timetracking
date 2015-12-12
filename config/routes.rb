Rails.application.routes.draw do
  root to: 'site#home'
  resources :projects do
    resources :entries
  end
end
