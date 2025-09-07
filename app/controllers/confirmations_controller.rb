class ConfirmationsController < ApplicationController
  layout "auth"
  allow_unauthenticated_access
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }
  before_action :set_user_by_confirmation_token, only: %i[edit update]

  def new
  end

  def create
    if (user = User.find_by(email_address: params[:email_address], confirmed_at: nil))
      user.touch
      ConfirmationMailer.confirm(user).deliver_later
    end

    redirect_to new_session_path, notice: "If this email exists, you will receive a confirmation link."
  end

  def edit
    if @user.confirmed_at.present?
      redirect_to new_session_path, notice: "Email address has already been confirmed."
    end
  end

  def update
    @user.update!(confirmed_at: Time.current)

    redirect_to new_session_path, notice: "Email address has been confirmed."
  end

  private

  def set_user_by_confirmation_token
    @user = User.find_by_token_for!(:confirmation, params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_confirmations_path, alert: "Confirmation link is invalid or has expired."
  end
end
