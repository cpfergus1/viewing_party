Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'sessions#login', as: :login
  delete '/logout', to: 'sessions#logout', as: :logout

  resources :users, only: [:create]
  get '/registration', to: 'users#new', as: :registration

  resources :discover, only: [:index]

  namespace 'user', path: ':user_id' do
    resource :dashboard, only: [:show], controller: :dashboard
    resource :friendships, only: [:create]
  end

  resources :movies, only: [:index, :show] do
    resources :viewing_party, only: [:new, :create]
  end
end
