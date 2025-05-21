class BaseController < ApplicationController
  before_action :authenticate_admin!, only: [:admin]

  def admin
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
