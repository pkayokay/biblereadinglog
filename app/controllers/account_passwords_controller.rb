class AccountPasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if Current.user.update(password_params)
      redirect_to edit_account_path, notice: "Password updated successfully."
    else
      flash.now[:alert] = Current.user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
