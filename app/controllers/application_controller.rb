class ApplicationController < ActionController::Base
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
    reset_session
    session[:user_id] = user.id
  end
end
