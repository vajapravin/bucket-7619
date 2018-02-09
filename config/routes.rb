Rails.application.routes.draw do

  scope format: true, constraints: { format: 'json' } do

    devise_for :users, controllers: { invitations: 'users/invitations',
                                      sessions: 'users/sessions' }, path: 'api/v1/users'

    namespace :api do
      namespace :v1 do
        resources :activities, only: %i(index create)
        resources :customers, only: %i(index create update)

        get 'profile' => 'misc#profile'
      end
    end
  end

end
