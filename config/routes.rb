Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # Authentication API
      resources :authentication, only: [:create] do
        collection do
          get 'validate_token'
          post 'login'
          post 'forgot_password'
          post 'reset_password'
          post 'reset_password_by_token'
          post 'check_by_email'
          post 'enter_sign_up_code'
        end
      end

      # Admin API
      namespace :admin do
        resources :lessons, only: [:index]
      end
    end
  end
end
