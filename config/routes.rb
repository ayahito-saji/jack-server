Rails.application.routes.draw do
  get 'products/index'
  get 'products/new'
  post 'products/create'
  get 'products/:id' => 'products#show'
  get 'products/:id/edit' => 'products#edit'
  post 'products/:id/update' => 'products#update'
  post 'products/:id/destroy' => 'products#destroy'

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
  resources :members, param: :member_id
  resources :events, param: :event_id

  root 'pages#index'

  # API部分
  scope :api do
    post 'slack/callback', to: 'slack#callback'
    get 'attendance', to: 'attendance#new'
    get 'events/seed', to: 'events#seed'
    get 'members/seed', to: 'members#seed'
  end
end
