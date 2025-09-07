class AccountsController < ApplicationController
  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    if @user.update(user_params)
      notice = if params[:update_type] == "time_zone"
        "Timezone updated successfully."
      elsif params[:update_type] == "password"
        "Password updated successfully."
      else
        "Account updated successfully."
      end

      redirect_to edit_account_path, notice: notice
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:time_zone, :password, :password_confirmation])
  end
end

