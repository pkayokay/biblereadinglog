class ReadingLogsController < ApplicationController
  before_action :set_reading_log, only: [:update, :show, :settings, :destroy]
  before_action :set_books_data, only: [:new, :create]

  def index
    @reading_logs = current_user.reading_logs.order(created_at: :desc)

    unless current_user.reading_logs.exists?
      redirect_to new_reading_log_path
    end
  end

  def new
    set_reading_log_index_breadcrumb
    add_breadcrumb("New Reading Log")
    @reading_log = ReadingLog.new
  end

  def update
    set_reading_log_index_breadcrumb
    # set_reading_log_settings_breadcrumb

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
    set_reading_log_index_breadcrumb
    set_reading_log_show_breadcrumb(with_link: false)
    @pinned_books = @reading_log.books.where.not(pin_order: nil).order(pin_order: :asc)
    @books = @reading_log.ordered_books.where(pin_order: nil)
    @has_unpinned_books = @reading_log.books.where(pin_order: nil).exists?
  end

  def settings
    set_reading_log_index_breadcrumb
    set_reading_log_show_breadcrumb
    set_reading_log_settings_breadcrumb
  end

  def destroy
    if @reading_log.destroy
      redirect_to reading_logs_path, notice: "Reading Log was deleted."
    else
      redirect_to settings_reading_log_path(@reading_log), alert: "Reading Log was not destroyed. Please try again."
    end
  end

  private

  def set_reading_log
    @reading_log = current_user.reading_logs.find(params[:id])
  end

  def reading_log_params
    params.require(:reading_log).permit(:name, :is_entire_bible, :reminder_frequency)
  end

  def set_books_data
    @books_data = JSON.parse(File.read('./public/books.json'))
    @old_testament_books_data = @books_data.slice(0,39)
    @new_testament_books_data = @books_data.slice(39,66)
  end

  def set_reading_log_index_breadcrumb
    add_breadcrumb("Reading Logs", root_path)
  end

  def set_reading_log_show_breadcrumb(with_link: true)
    add_breadcrumb(@reading_log.name, with_link ? reading_log_path(@reading_log) : nil)
  end

  def set_reading_log_settings_breadcrumb
    add_breadcrumb("Settings")
  end
end
