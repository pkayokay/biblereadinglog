class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to sign_in_path, alert: "You must be signed in" unless user_signed_in?
  end

  def require_no_user!
    redirect_to root_path if user_signed_in?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      user if user.present?
    end
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def sign_in(user)
    Current.user = user
    user.update(last_sign_in_at: Time.current)
    reset_session
    session[:user_id] = user.id
  end

  def sign_out
    Current.user = nil
    reset_session
  end
end
