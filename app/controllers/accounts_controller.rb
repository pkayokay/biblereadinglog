class AccountsController < ApplicationController
  def edit
  end

  def update
    if Current.user.update(user_params)
      redirect_to edit_account_path, notice: "Timezone updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:time_zone])
  end
end

