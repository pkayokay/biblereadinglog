class ReadingLogsController < ApplicationController
  before_action :set_reading_log, only: [:update, :show, :settings]

  def index
    @reading_logs = current_user.reading_logs.order(created_at: :desc)

    unless current_user.reading_logs.exists?
      redirect_to new_reading_log_path
    end
  end

  def new
    @reading_log = ReadingLog.new
  end

  def update
    if @reading_log.update(reading_log_params)
      redirect_to reading_log_path(@reading_log), notice: "Reading log updated!"
    else
      @errors = @reading_log.errors
      render :new, status: :unprocessable_entity
    end
  end

  def create
    @reading_log = current_user.reading_logs.new(reading_log_params)

    if @reading_log.save
      redirect_to reading_log_path(@reading_log), notice: "Reading log created"
    else
      @errors = @reading_log.errors
      render :new, status: :unprocessable_entity
    end
  end

  def show
    add_breadcrumb("Home", root_path)
    add_breadcrumb(@reading_log.name, reading_log_path(@reading_log))

    @old_testament_books = @reading_log.ordered_books.in_old_testament
    @new_testament_books = @reading_log.ordered_books.in_new_testament
  end

  def settings
    add_breadcrumb("Home", root_path)
    add_breadcrumb(@reading_log.name, reading_log_path(@reading_log))
    add_breadcrumb("Settings", settings_reading_log_path(@reading_log))



  end

  private

  def set_reading_log
    @reading_log = current_user.reading_logs.find(params[:id])
  end

  def reading_log_params
    params.require(:reading_log).permit(:name)
  end
end
