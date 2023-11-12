Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :merchants, only: [:index] do
    resource :dashboard, only: :show, to: "merchants#show"

    resources :items, controller: "merchants/items" do
      resource :status, controller: "merchants/items/status", only: :update
    end
    
    resources :invoices, controller: "merchants/invoices", only: [:show, :index, :update]

    resources :discounts, controller: "merchants/discounts", only: [:index, :show, :new, :create]
  end

  namespace :merchants do
    resources :invoices, only: [:index, :update]
    resources :items, only: :show
    resources :discounts, only: [:index, :show, :new, :create]
  end
  
  root "merchants#index"

  namespace :admin do
    get "/", to: "dashboards#welcome"

    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
  end
end
