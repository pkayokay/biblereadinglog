class ReadingLogsController < ApplicationController
  before_action :set_reading_log, only: %i[show edit]

  def index
    @reading_logs = if params[:status] == "finished"
      Current.user.reading_logs.completed.order(updated_at: :desc)
    else
      Current.user.reading_logs.in_progress.order(updated_at: :desc)
    end
  end

  def new
    @reading_log = Current.user.reading_logs.new
  end

  def show
  end

  def create
    @reading_log = Current.user.reading_logs.new(reading_log_params)

    if @reading_log.save
      redirect_to reading_log_path(@reading_log)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reading_log_params
    params.expect(reading_log: [:is_entire_bible, :name])
  end

  def set_reading_log
    @reading_log = Current.user.reading_logs.find(params[:id])
  end
end
