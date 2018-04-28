Rails.application.routes.draw do
  resources :deposits
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions',
                                   passwords: 'passwords', confirmations: 'confirmations'}

  devise_scope :user do
    authenticated :user do
      root 'home#dashboard', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, except: [:create] do
    get 'select_workers'
    post 'add_workers'
    delete 'remove_worker'
  end

  resources :workers do
    get 'offline', on: :collection
    get 'select_customers'
    post 'add_customers'
    delete 'remove_user'
  end

end
