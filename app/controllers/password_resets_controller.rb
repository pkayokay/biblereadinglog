class PasswordResetsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :require_no_user!
  before_action :set_user_by_token, only: [:edit, :update]

  def new
  end

  def create
    if (user = User.find_by(email: params[:email].presence))
      UserMailer.with(
        user:,
        token: user.generate_token_for(:password_reset)
      ).password_reset.deliver_later
    end

    redirect_to sign_in_path, notice: "If this email exists, you'll receive an email to reset your password."
  end

  def edit
  end

  def update
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Password reset successfully, please login."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    redirect_to new_password_reset_path, alert: "Invalid token, please try again" unless @user.present?
  end
end