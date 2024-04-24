class UsersController < ApplicationController
  def account
  end

  def update_password
    if current_user.update(password_params)
      redirect_to account_path, notice: "Password updated"
    else
      render :account, status: :unprocessable_entity
    end
  end

  def update_time_zone
    if current_user.update(time_zone_params)
      redirect_to account_path, notice: "Time zone updated"
    else
      render :account, status: :unprocessable_entity
    end
  end


  def update_color_theme
    if current_user.update(color_theme_params)
      redirect_to account_path, notice: "Color theme updated"
    else
      render :account, status: :unprocessable_entity
    end
  end


  def update_name
    if current_user.update(name_params)
      redirect_to account_path, notice: "Name updated"
    else
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
