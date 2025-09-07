class RegistrationsController < ApplicationController
  layout "auth"
  prevent_authenticated_access
  allow_unauthenticated_access
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      start_new_session_for @user
      ConfirmationMailer.confirm(@user).deliver_later

      redirect_to reading_logs_path
    else
      render :new, status: :unprocessable_content
    end
  end

  def user_params
    params.expect(user: [:email_address, :password, :password_confirmation])
  end
end
