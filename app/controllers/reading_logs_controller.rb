class ReadingLogsController < ApplicationController
  before_action :set_reading_log, only: [:update, :show, :settings, :destroy]
  before_action :set_books_data, only: [:new, :create]

  def index
    @skip_turbo_cache_control = true
    @has_completed_status = params[:status] == "completed"
    @item_count = 10

    @pagy, @reading_logs = if @has_completed_status
      pagy(current_user.reading_logs.complete.order(created_at: :desc), items: @item_count)
    else
      pagy(current_user.reading_logs.pending.order(created_at: :desc), items: @item_count)
    end

    if current_user.confirmed_at.nil?
      redirect_to email_confirmation_path
    else
      unless current_user.reading_logs.exists?
        redirect_to new_reading_log_path
      end
    end
  end

  def new
    if current_user.confirmed_at.nil?
      redirect_to email_confirmation_path
    end

    add_breadcrumb("New Reading Log")
    if current_user.reading_logs.exists?
      @back_button_values = {
        path: root_path,
        text: "Back to Reading Logs"
      }
    end
    @reading_log = ReadingLog.new
  end

  def update
    @back_button_values = {
      path: reading_log_path(@reading_log),
      text: "Back to #{@reading_log.name}",
    }
    set_reading_log_show_breadcrumb
    set_reading_log_settings_breadcrumb

    @reading_log.assign_attributes(reading_log_params)
    if @reading_log.is_reminder_enabled?
      @reading_log.reminder_scheduled_at = CalculateReminderScheduledAtService.new(reading_log: @reading_log).call
    end

    if @reading_log.save
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
    @skip_turbo_cache_control = true
    @back_button_values = {
      path: root_path,
      text: "Back"
    }

    set_reading_log_show_breadcrumb(with_link: false)

    @has_pending_status = params[:status] == "pending"
    @has_completed_status = params[:status] == "completed"
    @has_no_status = params[:status].blank?

    if @has_pending_status
      @books = @reading_log.ordered_books.pending
    elsif @has_completed_status
      @books = @reading_log.ordered_books.complete
    else
      @books = @reading_log.ordered_books.unpinned
      @pinned_books = @reading_log.books.pinned.order(pin_order: :asc)
    end

    @has_unpinned_books = @books.present?
  end

  def settings
    @back_button_values = {
      path: reading_log_path(@reading_log),
      text: "Back to #{@reading_log.name}",
    }
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
    allowed_params = params.require(:reading_log).permit(
      :name,
      :is_entire_bible,
      :is_reminder_enabled,
      :reminder_frequency,
      :reminder_time,
      reminder_days: [],
      reminder_days_multiple: {},
    )
    if allowed_params[:is_reminder_enabled] == "1"
      allowed_params[:reminder_days] = handle_reminder_days_value(allowed_params)
    else
      allowed_params.delete(:reminder_days)
      allowed_params.delete(:reminder_frequency)
      allowed_params.delete(:reminder_time)
    end

    allowed_params.except(:reminder_days_multiple)
  end

  def set_books_data
    @books_data = JSON.parse(File.read('./public/books.json'))
    @old_testament_books_data = @books_data.slice(0,39)
    @new_testament_books_data = @books_data.slice(39,66)
  end

  def set_reading_log_show_breadcrumb(with_link: true)
    add_breadcrumb(@reading_log.name, with_link ? reading_log_path(@reading_log) : nil)
  end

  def set_reading_log_settings_breadcrumb
    add_breadcrumb("Settings")
  end

  def handle_reminder_days_value(allowed_params)
    daily_reminder_frequency = allowed_params[:reminder_frequency] == "daily"

    if daily_reminder_frequency
      selected_days = allowed_params[:reminder_days_multiple].select { |day, value| value == "1" }.keys
      selected_days
    else
      allowed_params[:reminder_days].compact_blank
    end
  end
end
