class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :require_no_user!

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @user.confirmed_at = Time.current if ENV['EMAILS_DISABLED'] == "true"

    if @user.save
      sign_in(@user)

      UserMailer.with(
        user: @user,
        token: @user.generate_token_for(:email_confirmation)
      ).email_confirmation.deliver_later

      redirect_to root_path
    else
      @errors = @user.errors
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    allowed_params = params.require(:user).permit(:email, :time_zone, :first_name, :last_name, :password, :password_confirmation)
    allowed_params[:time_zone] = ActiveSupport::TimeZone::MAPPING.key(allowed_params[:time_zone])
    allowed_params
  end
end