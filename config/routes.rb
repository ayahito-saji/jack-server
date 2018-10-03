Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :member, skip: :all
  devise_scope :member do
    get 'login'             => 'devise/sessions#new',           as: :new_member_session
    post 'login'            => 'devise/sessions#create',        as: :member_session
    delete 'logout'         => 'devise/sessions#destroy',       as: :destroy_member_session
    get 'signup'            => 'devise/registrations#new',      as: :new_member_registration
    post 'signup'           => 'devise/registrations#create',   as: :member_registration
    get 'signup/cancel'     => 'devise/registrations#cancel',   as: :cancel_member_registration
    get 'member'            => 'devise/registrations#edit',     as: :edit_member_registration
    patch 'member'          => 'devise/registrations#update',   as: nil
    put 'member'            => 'devise/registrations#update',   as: :update_member_registration
    delete 'member'         => 'devise/registrations#destroy',  as: :destroy_member_registration
    get 'password'          => 'devise/passwords#new',          as: :new_member_password
    post 'password'         => 'devise/passwords#create',       as: :member_password
    get 'password/edit'     => 'devise/passwords#edit',         as: :edit_member_password
    patch 'password'        => 'devise/passwords#update'
    put 'password'          => 'devise/passwords#update',       as: :update_member_password
    get 'confirmation/new'  => 'devise/confirmations#new',      as: :new_member_confirmation
    get 'confirmation'      => 'devise/confirmations#show',     as: :member_confirmation
    post 'confirmation'     => 'devise/confirmation#create',    as: nil
  end
  resources :members, param: :username

  root 'pages#index'

  scope :api do
    get 'attendance', to: 'attendance#new'
    post 'slack/callback', to: 'callback#slack'

  end
end
