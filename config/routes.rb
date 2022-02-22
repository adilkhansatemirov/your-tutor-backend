Rails.application.routes.draw do
  mount GoodJob::Engine => '/good_job'

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
        resources :projects, except: :destroy do
          member do
            post 'pay_freelancer'
            post 'deactivate'
            post 'assign_freelancer'
            # post 'start_bids'
            get 'uninvoiced_time_entries'
            post 'enable_automated_invoicing'
            post 'disable_automated_invoicing'
          end
        end
        resources :client_details, only: [:index, :create] do
          get 'all', on: :collection
        end
        resources :payments, only: :index
        resources :freelancer_details, only: [:index, :update] do
          get 'all', on: :collection
        end
        resources :freelancers, only: [:show, :destroy] do
          member do
            post 'upload_resume'
            post 'qualify'
          end
          collection do
            get 'info'
          end
        end
        resources :users do
          member do
            post 'block'
            post 'unblock'
          end
        end
        resources :invoices, except: :destroy do
          post 'charge_client', on: :member
        end
        resources :freelancer_skills, only: [:show, :update]
        resources :timesheets, only: [:index, :show, :update] do
          post 'pay_freelancer', on: :member
        end
      end

      # Client API
      namespace :client do
        resources :invoices, only: [:index, :show]
        # resources :projects, only: [:index, :show, :create]
        resources :client_details do
          post 'connect_card', on: :collection
          post 'connect_bank', on: :collection
        end
      end

      # Freelancer API
      namespace :freelancer do
        resources :projects, only: [:index, :show]
        resources :freelancers do
          collection do
            get 'current'
            post 'update_freelancer_detail'
            post 'finish_all_steps'
            post 'upload_resume'
            post 'connect_stripe'
            post 'generate_express_dashboard_link'
          end
        end
        resources :opportunities, only: [:index, :show]
        resources :project_bids, only: :update
        resources :timesheets, except: :index
        resources :time_entries, except: [:index, :show]
        resources :freelancer_skills, only: :index do
          collection do
            get 'all'
            post 'update_skills'
          end
        end
      end

      # Common API
      resources :allowed_notifications, only: [:show, :update], param: :user_id
      # post 'support/send_email_to_admin' => 'support#send_email_to_admin'
    end
  end
end
