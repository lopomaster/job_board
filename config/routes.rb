Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_for :users,
                 controllers: {
                     sessions: 'api/v1/sessions', registrations: 'api/v1/registrations'
                 }
    end
  end

  # todo Web app
  root to: 'home#index'
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

end