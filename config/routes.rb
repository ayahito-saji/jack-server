Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :members

  root 'pages#index'

  scope :api do
    get 'attendance', to: 'attendance#new'

    post 'slack/callback', to: 'callback#slack'

  end
end
