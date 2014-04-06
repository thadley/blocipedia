Blocipedia::Application.routes.draw do

  get "welcome/index"
  get "welcome/about"
  
  devise_for :users
  resources :wikis

  root 'welcome#index'

end
