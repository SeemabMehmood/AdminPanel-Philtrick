Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'sessions'}

  devise_scope :user do
    authenticated :user do
      root 'home#dashboard', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users do
    get 'select_workers'
    post 'add_workers'
  end

  resources :workers do
    get 'select_customers'
    post 'add_customers'
  end

end
