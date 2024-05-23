class BaseController < ApplicationController
  def admin
    redirect_to root_path unless current_user.is_admin?
  end

  def feedback
  end

  def flash_message
    flash.now[:notice] = params[:message]
    render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
  end

  def settings
  end
end
