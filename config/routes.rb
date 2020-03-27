Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'static#home'
  get 'homepage', to:'static#homepage'
  get 'myproject', to:'projects#ongoing_project'
  get 'tags/:tag', to: 'projects#index', as: :tag
  get 'aboutus', to:'static#aboutus'

  resources :posts do
    resources :comments
  end

  resources :users, only: [:show] do
    resources :avatars, only: [:new, :create]
  end

  resources :projects, only: [:edit] do
    resources :images, only: [:new, :create]
  end


  resources :users do
    resources :skill_setups
  end

  resources :projects do
    resources :charges, path: 'paiement'
    resources :attendances, path: 'inscription'
  end

    namespace :admin do
    root 'admin#index'
    resources :users, :projects, :project_submissions
  end

end
