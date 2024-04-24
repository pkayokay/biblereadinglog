class ReadingLogsController < ApplicationController
  before_action :set_reading_log, only: [:show, :settings]

  def index
    @reading_logs = current_user.reading_logs
  end

  def show
    add_breadcrumb("Home", root_path)
    add_breadcrumb("Reading Log", reading_log_path(@reading_log))

    @old_testament_books = @reading_log.ordered_books.in_old_testament
    @new_testament_books = @reading_log.ordered_books.in_new_testament
  end

  def settings
    add_breadcrumb("Home", root_path)
    add_breadcrumb("Reading Log", reading_log_path(@reading_log))
    add_breadcrumb("Settings", settings_reading_log_path(@reading_log))
  end

  private

  def set_reading_log
    @reading_log = current_user.reading_logs.find(params[:id])
  end
end
