Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users/registrations#new"

  namespace :users do
    resources :registrations, only: %i[new create]
  end

  resource :dashboard, controller: "dashboard"
end
