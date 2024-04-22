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

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
