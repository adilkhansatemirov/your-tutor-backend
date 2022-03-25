Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # Authentication API
      resources :authentication, only: [:create] do
        collection do
          get "validate_token"
          post "login"
          post "forgot_password"
          post "reset_password"
          post "reset_password_by_token"
          post "check_by_email"
          post "enter_sign_up_code"
        end
      end

      # Admin API
      namespace :admin do
        resources :projects, except: :destroy do
          member do
            post "pay_freelancer"
            post "deactivate"
            post "assign_freelancer"
            # post 'start_bids'
            get "uninvoiced_time_entries"
            post "enable_automated_invoicing"
            post "disable_automated_invoicing"
          end
        end
        resources :student_details, only: [:index, :create] do
          get "all", on: :collection
        end
        resources :payments, only: :index
        resources :tutor_details, only: [:index, :update] do
          get "all", on: :collection
        end
        resources :freelancers, only: [:show, :destroy] do
          member do
            post "upload_resume"
            post "qualify"
          end
          collection do
            get "info"
          end
        end
        resources :users do
          member do
            post "block"
            post "unblock"
          end
        end
        resources :invoices, except: :destroy do
          post "charge_client", on: :member
        end
        resources :freelancer_skills, only: [:show, :update]
        resources :timesheets, only: [:index, :show, :update] do
          post "pay_freelancer", on: :member
        end
      end
    end
  end
end
