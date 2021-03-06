Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' }

      resources :users, except: [:edit, :new, :show] do
        get :subscribe_to_advert
      end
      get 'user/:username', to: 'users#show', as: :username

      resources :job_adverts, except: :index do
        get :my_adverts_as_candidate, on: :collection
        get :my_adverts_as_company, on: :collection
        get :list_adverts, on: :collection
      end
      resources :job_subscriptions, except: :index do
        get :my_subscriptions_as_candidate, on: :collection
        get :my_subscriptions_as_company, on: :collection
      end

    end
  end

  # todo Web app
  root to: 'home#index'
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

  match "*path", to: "api/v1/application#routing_error", via: :all

end