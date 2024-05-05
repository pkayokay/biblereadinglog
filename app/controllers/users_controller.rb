class UsersController < ApplicationController
  def account
  end

  def email_confirmation
  end

  def resend_email_confirmation
    flash[:notice] = "Email confirmation sent!"
    current_user.touch # Invalidate previous token

    UserMailer.with(
      user: current_user,
      token: current_user.generate_token_for(:email_confirmation)
    ).email_confirmation.deliver_later

    redirect_to email_confirmation_path
  end

  def update_password
    if current_user.update(password_params)
      redirect_to account_path, notice: "Password updated!"
    else
      @password_errors = current_user.errors
      render :account, status: :unprocessable_entity
    end
  end

  def update_time_zone
    if current_user.update(time_zone_params)
      redirect_to account_path, notice: "Time zone updated!"
    else
      @time_zone_errors = current_user.errors
      render :account, status: :unprocessable_entity
    end
  end


  def update_color_theme
    if current_user.update(color_theme_params)
      redirect_to account_path, notice: "Color theme updated!"
    else
      @color_theme_errors = current_user.errors
      render :account, status: :unprocessable_entity
    end
  end


  def update_name
    if current_user.update(name_params)
      redirect_to account_path, notice: "Name updated!"
    else
      @name_errors = current_user.errors
      render :account, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end

  def time_zone_params
    params.require(:user).permit(:time_zone)
  end

  def color_theme_params
    params.require(:user).permit(:color_theme)
  end

  def name_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
