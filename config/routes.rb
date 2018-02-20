Rails.application.routes.draw do
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :charges, only: [:new, :create]

  get 'welcome/index'

  get 'welcome/about'

  root 'wikis#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
