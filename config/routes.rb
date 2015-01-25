Lvhs::Application.routes.draw do
  class UseSubdomain
    def initialize(domain)
      @domain = domain
    end

    def matches?(request)
      Rails.env.development? ||
        (request.subdomain.present? && request.subdomain == @domain)
    end
  end

  devise_for :staffs, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'teaser/home#index'
  resources :support, only: [:index], controller: 'teaser/support'
  resources :terms, only: [:index], controller: 'teaser/terms'
  resources :privacy, only: [:index], controller: 'teaser/privacy'

  constraints UseSubdomain.new('api') do
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

    namespace :app do
      resources :artists,  only: [:show]
      resources :purchase, only: [:create]

      # CA Reward
      namespace :car do
        resources :list,  only: [:index]
        resources :error, only: [:index]
      end
    end
  end

  constraints UseSubdomain.new('app') do
    namespace :app do
      root to: 'home#index'

      resources :artists, only: [:show]

      resources :purchase, only: [:create]

      # CA Reward
      namespace :car do
        resources :list, only: [:index]
        resources :error, only: [:index]
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
