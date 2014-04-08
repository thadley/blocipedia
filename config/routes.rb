Blocipedia::Application.routes.draw do

  get "welcome/index"
  get "welcome/about"
  
  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]

  root 'welcome#index'

end
