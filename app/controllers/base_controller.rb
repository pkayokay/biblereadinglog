class BaseController < ApplicationController
  def index
  end

  def admin
    redirect_to root_path unless current_user.is_admin?
  end

  def setup_user
    result = SetupUserService.new(email: params[:email], password: params[:password]).call

    redirect_to admin_path, notice: "#{result[:email]} user created!"
  end
end
