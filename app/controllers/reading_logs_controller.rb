class ReadingLogsController < ApplicationController
  before_action :set_reading_log, only: [:update, :settings, :destroy]
  before_action :set_books_data, only: [:new, :create]

  skip_before_action :authenticate_user!, only: [:invite]

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
    end
  end

  def new
    if current_user.confirmed_at.nil?
      redirect_to email_confirmation_path
    end

    @reading_log = ReadingLog.new
  end

  def update
    save_reading_log = ReadingLog.transaction do
      @reading_log.assign_attributes(reading_log_params)

      if @reading_log.is_reminder_enabled?
        @reading_log.reminder_scheduled_at = CalculateReminderScheduledAtService.new(reading_log: @reading_log).call
      end

      unless @reading_log.template_reading_log_id.present?
        @reading_log.child_reading_logs.each do |child_reading_log|
          child_reading_log.name = @reading_log.name
          child_reading_log.save
        end
      end


      @reading_log.save
    end

    if save_reading_log
      redirect_to reading_log_path(@reading_log), notice: "Reading log updated!"
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
    @reading_log = ReadingLog.includes(:template_reading_log, child_reading_logs: :user).find(params[:id])
    @skip_turbo_cache_control = true

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
  end

  def invite
    @reading_log = ReadingLog.find_by(slug: params[:slug])

    if @reading_log
      if user_signed_in?
        unless @is_reading_log_owner = @reading_log.user == current_user
          @is_reading_log_member = @reading_log.child_reading_logs.where(user: current_user).exists?
        end
      end
    end
  end

  def join_invite
    flash.clear

    if current_user.confirmed_at.nil?
      flash[:alert] = "Confirm your email before joining"
      redirect_to email_confirmation_path
    else
      @reading_log = ReadingLog.find_by(slug: params[:slug])
      if @reading_log.present?
        if @reading_log.user == current_user
          flash[:notice] = "You are the owner of this reading log"
          redirect_to reading_log_path(@reading_log)
        elsif @child_reading_log = @reading_log.child_reading_logs.where(user: current_user).first
          flash[:notice] = "You are already part of this reading log"
          redirect_to reading_log_path(@child_reading_log)
        else
          @child_reading_log = current_user.reading_logs.new(
            name: @reading_log.name,
            is_entire_bible: @reading_log.is_entire_bible,
            books_count: @reading_log.books_count,
            template_reading_log: @reading_log,
          )
          @reading_log.books.each do |book|
            @child_reading_log.books.new(
              name: book["name"],
              slug: book["slug"],
              reading_log: @reading_log,
              position: book["position"],
              chapters_count: book["chapters_count"],
              chapters_data: book["chapters_count"].times.map do |index|
                chapter = index + 1
                { chapter_number: chapter, completed_at: nil }
              end,
            )
          end
          if @child_reading_log.save
            flash[:notice] = "You've been added to the reading log!"
            redirect_to reading_log_path(@child_reading_log)
          else
            flash[:alert] = "Something went wrong, try again."
            redirect_to root_path
          end
        end
      else
        flash[:alert] = "That reading log doesn't exist"
        redirect_to root_path
      end
    end
  end

  def destroy
    if @reading_log.destroy
      redirect_to root_path, notice: "Reading Log was deleted."
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
