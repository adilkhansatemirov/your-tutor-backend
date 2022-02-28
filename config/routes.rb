Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Admin API
      namespace :admin do
        resources :lessons, only: [:index]
      end
    end
  end
end
