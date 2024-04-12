class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, except: :destroy
  before_action :require_no_user!, except: :destroy

  def new
  end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      sign_in(user)
      redirect_to root_path, notice: "Signed in!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: "You have been logged out."
  end
end
