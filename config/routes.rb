Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: [:show, :index]
      resources :videos, only: [:show]
    end
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :videos, only: [:edit, :update, :destroy]
    resources :tutorials, except: [:index, :show] do
      resources :videos, only: [:create]
    end

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  resources :tutorials, only: [:show, :index]
  resources :user_videos, only: [:create, :destroy]
  resources :users, only: [:new, :create, :update, :edit] do
    get '/activation', to: 'activation#show'
    post '/friendships', to: 'friendships#create'
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/register', to: 'users#new'
  get '/signup', to: 'users#new'
  get '/dashboard', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'users#edit'

  get '/invite', to: 'invites#new'
  post '/invite', to: 'invites#create'
  # Is this being used?
  get '/video', to: 'video#show'
end
