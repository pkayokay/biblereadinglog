class ApplicationController < ActionController::Base
  def sign_in(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end
end
