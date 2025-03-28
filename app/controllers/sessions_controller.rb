class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, except: :destroy
  before_action :require_no_user!, except: :destroy

  def new
  end

  def create
    if (user = User.authenticate_by(email: params[:email].presence, password: params[:password]))
      user.update(time_zone: params[:time_zone]) if user.has_default_time_zone?
      sign_in(user)
      flash[:notice] = "Welcome back!"
      redirect_to params[:dest] || root_path
    else
      user = User.new
      user.errors.add(:base, "Invalid email or password")
      @errors = user.errors
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to sign_in_path
  end
end
