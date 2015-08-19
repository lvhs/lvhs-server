require 'routes/constraints/subdomain'

Lvhs::Application.routes.draw do

  root 'teaser/home#index'
  resources :support, only: [:index], controller: 'teaser/support'
  resources :terms, only: [:index], controller: 'teaser/terms'
  resources :privacy, only: [:index], controller: 'teaser/privacy'

  constraints Routes::Constraints::Subdomain::API do
    namespace :api do
      namespace :v1 do
        resources :home, only: [:index]

        resources :artists, only: [:show]

        # CA Reward
        namespace :car do
          resources :pointback, only: [:index]
          resources :list,      only: [:index]
          resources :error,     only: [:index]
        end
      end
    end
  end

  constraints Routes::Constraints::Subdomain::APP do
    namespace :app do
      root to: 'home#index'
      get 'callback', to: 'home#callback'

      resources :menu, only: [:index]

      resources :version, only: [:index]

      resources :artists, only: [:show]

      resources :products, only: [:index]

      resources :purchase, only: [:create]

      resources :users, only: [:new, :create, :show, :edit, :update] do
        member do
          get   'image', to: 'users/image#edit'
          patch 'image', to: 'users/image#update'
        end
      end
      resources :profile, only: [:index]

      resources :events do
        resources :comments, module: :events
        resources :entry, module: :events, only: [:create, :destroy]
      end

      # CA Reward
      namespace :car do
        resources :list, only: [:index]
        resources :error, only: [:index]
      end
    end
  end

  constraints Routes::Constraints::Subdomain::OPE do
    devise_for :staffs, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end

  mount Peek::Railtie => '/peek'
end
