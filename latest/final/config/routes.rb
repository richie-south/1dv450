require 'api_constraints'

Rails.application.routes.draw do
  mount Knock::Engine => "/knock"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  root 'users#index'

  resources :users
  resources :apikeys, only: [:index, :create, :new, :destroy]

  #get 'show' => 'apikeys#show', as: :apikey


  #post 'destroy' => 'apikeys#destroy', as: :destroy
  #post 'new', to: 'apikeys#new', as: :new
  #post 'create' => 'apikeys#create', as: :create


  post 'login' => 'users#login', :as => "login"
  get 'logout' => 'users#logout', as: :logout


  namespace :api, defaults: { format: :json } do
    scope module: :v1, constrains: ApiConstraints.new(version: 1, default: true) do

        resources :toilets, only: [:show, :index, :create, :new, :destroy, :update] do
            resources :positions, only: [:index]
            resources :tags, only: [:index]
        end
        resources :positions, only: [:show, :index, :create, :new, :destroy, :update]
            resources :tags, only: [:show, :index, :create, :new, :destroy, :update] do
            resources :toilets, only: [:index]
        end
        resources :creators, only: [:show, :index] do
            resources :toilets, only: [:index]
        end

    end
  end

end
