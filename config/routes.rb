Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "search#show"
      end
      namespace :items do
        get "/find_all", to: "search#index"
      end
      namespace :revenue do
        get "/items", to: "items#index"
        get "/merchants", to: "merchants#index"
        get "/merchants/:id", to: "merchants#show"
        get "/unshipped", to: "unshipped#index"
      end
      resources :merchants, only: %i[index show]
      get "/merchants/:id/items", to: "merchants#items_index"
      resources :items, only: %i[index show create update destroy]
      get "/items/:id/merchant", to: "items#merchant_show"
    end
  end
end
