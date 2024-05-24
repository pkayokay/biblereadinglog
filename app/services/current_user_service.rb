class CurrentUserService
  def self.set_session_user(session:)
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      user if user.present?
    end
  end
end
