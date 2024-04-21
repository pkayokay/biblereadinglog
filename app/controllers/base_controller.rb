class BaseController < ApplicationController
  def admin
    redirect_to root_path unless current_user.is_admin?
  end

  def setup_user
    result = SetupUserService.new(email: params[:email], password: params[:password]).call

    if result[:success]
      flash[:notice] = "#{result[:email]} user created!"
    else
      flash[:alert] = result[:error]
    end

    redirect_to admin_path
  end

  def settings
  end
end
