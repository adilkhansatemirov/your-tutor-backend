class Api::V1::AuthenticationController < ApplicationController
  before_action :authenticate_api_user!, only: [:validate_token]

  # POST /authentication/check_by_email
  def check_by_email
    user = User.find_by_email(params[:email])
    if user.nil?
      render json: {
        success: false,
      }, status: 401
    elsif user.is_legacy_user && !user.is_password_set
      ResetPasswordNotifierMailer.send(user.email, "")
      render json: {
        success: false,
      }, status: 428
    else
      render json: {
        success: true
      }, status: 200 
    end
  end

  # POST /authentication - Sign up
  def create
    generated_password = Devise.friendly_token.first(8)
    user = User.new(sign_up_params)
    user.role = 'freelancer'
    if user.save
      UserNotifierMailer.send(user.email, generated_password)
      FreelancerDetail.create(user_id: user.id, sign_up_code: generated_password)
      AllowedNotification.create(
        user_id: user.id,
        new_opportunity_available: true,
        project_bid_accepted: true,
        timesheet_rejected: true,
        new_timesheet_submitted: false,
        new_invoice_submitted: false,
        new_freelancer_signed_up: false
      )
      render json: UserBlueprint.render(user, view: :auth)
    else
      render json: { error: "Unable to create account" }, status: 422
    end
  end

  # POST /authentication/enter_sign_up_code
  def enter_sign_up_code
    user = User.find_by!(email: enter_code_params[:email])
    if user.freelancer_detail.sign_up_code == enter_code_params[:sign_up_code]
      user.freelancer_detail.update_attribute(:sign_up_code_entered, true)
      Freelancer::NotificationsService.notify_about_new_freelancer(user)
      render json: { message: "User activated" }, status: 200
    else
      render json: { 
        error: "Verification code is incorrect code. Please, check the email. And enter the Verification code."
      }, status: 428
    end
  end

  # POST /authentication/login
  def login 
    user = User.find_for_database_authentication(email: login_params[:email])
    if user&.valid_password?(login_params[:password])
      if user.role === 'client'
        client_detail = user.client_detail
        return render json: {
          data: {
            user: user,
            client_detail: client_detail,
            has_payment_info: !client_detail.stripe_customer_id.nil?
          },
          token: user.token
        } 
      elsif user.role === 'freelancer'
        if user && !user.freelancer_detail.sign_up_code_entered
          render json: {
              success: false,
              error: "No verification code entered. Please, check the mail. And enter the verification code."
          }, status: 428 and return
        end

        freelancer_detail = user.freelancer_detail

        return render json: {
          data: {
            user: user,
            freelancer_detail: freelancer_detail
          },
          token: user.token
        }
      else 
        return render json: {
          data: {
            user: user,
          },
          token: user.token
        }
      end
      # render json: UserBlueprint.render(user, root: :data, view: :auth)
    else
      render json: { error: "Email or password is incorrect" }, status: 401
    end
  end

  # GET /authentication/validate_token
  def validate_token
    user = User.find(current_api_user.id)
    if user.role === 'freelancer'
      return render json: {
        data: {
          user: user,
          freelancer_detail: user.freelancer_detail,
        }
      }
    end

    if user.role === 'client'
      return render json: {
        data: {
          user: user,
          client_detail: user.client_detail,
          has_payment_info: !user.client_detail.stripe_customer_id.nil?
        }
      }
    end
    
    return render json: {
      data: {
        user: user,
      }
    }
    
  end

  # POST /authentication/reset_password
  def reset_password
    user = User.find_by_email(reset_password_params[:email])
    password = reset_password_params[:password]
    if user&.reset_password(password, password)
      render json: {
        success: true,
        errors: ["Update password"]
    }, status: 200
    else
      render json: {
        success: false,
        errors: ["Not update password"]
    }, status: 401
    end
  end

  # POST /authentication/reset_password_by_token
  def reset_password_by_token
    user = User.reset_password_by_token(reset_password_by_token_params)
    if user.errors.empty?
      if user.is_legacy_user
        user.is_password_set = true
        user.save
      end
      render json: { user: user }
    else
      render json: {
        success: false,
        error: "Password change error"
    }, status: :bad_request
    end
  end

  # POST /authentication/forgot_password
  def forgot_password
    user = User.find_by_email(params[:email])
    if user
      ResetPasswordNotifierMailer.send(user.email, "")

      render json: {
        success: true,
        massage: ["You will receive a reset link in your email"]
    }, status: 200    
    else
      render json: {
        success: false,
        errors: ["You are not registered"]
    }, status: 401
    end
  end

  private

  def login_params
    params.permit(
      :email,
      :password
    )
  end

  def sign_up_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password
    )
  end

  def enter_code_params 
    params.permit(
      :email,
      :sign_up_code
    )
  end

  def reset_password_params
    params.permit(
      :email,
      :password
    )
  end

  def reset_password_by_token_params
    params.require(:token).permit(
      :reset_password_token,
      :password,
      :password_confirmation
    )
  end

end
