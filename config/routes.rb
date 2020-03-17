Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :skill_setups
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:index]
  root to: "static#home"
  get 'home', to:'static#home'
end
