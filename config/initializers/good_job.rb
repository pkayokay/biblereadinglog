ActiveSupport.on_load(:good_job_application_controller) do
  def is_admin_user?
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      user&.is_admin?
    end
  end

  before_action do
    raise ActionController::RoutingError.new("Not Found") unless is_admin_user?
  end
end
