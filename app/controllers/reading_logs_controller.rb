class ReadingLogsController < ApplicationController
  before_action :set_reading_log, only: [:update, :show, :settings]
  before_action :set_books_data, only: [:new, :create]

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
    set_reading_log_breadcrumb
    set_reading_log_settings_breadcrumb

    if @reading_log.update(reading_log_params)
      redirect_to settings_reading_log_path(@reading_log), notice: "Reading log updated!"
    else
      @errors = @reading_log.errors
      render "reading_logs/settings", status: :unprocessable_entity
    end
  end

  def create
    @reading_log = current_user.reading_logs.new(reading_log_params)

    if @reading_log.is_entire_bible?
      BuildBooksService.new(reading_log: @reading_log).call
    else
      selected_books = params[:reading_log][:selected_books].as_json.filter_map {|a| {a.first => a.last } if a.last == "1"}
      BuildBooksService.new(reading_log: @reading_log, selected_books: selected_books).call
    end

    if @reading_log.save
      redirect_to reading_log_path(@reading_log), notice: "Reading log created!"
    else
      @errors = @reading_log.errors
      render :new, status: :unprocessable_entity
    end
  end

  def show
    set_reading_log_breadcrumb
    @books = @reading_log.ordered_books
  end

  def settings
    set_reading_log_breadcrumb
    set_reading_log_settings_breadcrumb
  end

  private

  def set_reading_log
    @reading_log = current_user.reading_logs.find(params[:id])
  end

  def reading_log_params
    params.require(:reading_log).permit(:name, :is_entire_bible)
  end

  def set_books_data
    @books_data = JSON.parse(File.read('./public/books.json'))
    @old_testament_books_data = @books_data.slice(0,39)
    @new_testament_books_data = @books_data.slice(39,66)
  end

  def set_reading_log_breadcrumb
    add_breadcrumb("Home", root_path)
    add_breadcrumb(@reading_log.name, reading_log_path(@reading_log))
  end

  def set_reading_log_settings_breadcrumb
    add_breadcrumb("Settings", settings_reading_log_path(@reading_log))
  end
end
