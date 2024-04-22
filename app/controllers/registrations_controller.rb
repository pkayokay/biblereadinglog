class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :require_no_user!

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end