Rails.application.routes.draw do

  scope format: true, constraints: { format: 'json' } do

    devise_for :users, controllers: { invitations: 'users/invitations',
                                      sessions: 'users/sessions',
                                      registrations: 'users/registrations' }, path: 'api/v1/users'

    namespace :api do
      namespace :v1 do
        resources :transactions, only: %i(index create update destroy)
        resources :users, shallow: true do
          resources :transactions
        end
      end
    end
  end

end
