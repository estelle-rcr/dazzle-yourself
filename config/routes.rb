Rails.application.routes.draw do
  get 'packages/index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users

  resources :users do
    resources :skill_setups
  end

  resources :projects do
    resources :charges, path: 'paiement'
    resources :attendances, path: 'inscription'
  end

  root to: 'static#home'

  get 'homepage', to:'static#homepage'

end
