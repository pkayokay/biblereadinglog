class ReadingLogsController < ApplicationController
  def index
    @reading_logs = current_user.reading_logs
  end

  def show
    reading_log = current_user.reading_logs.find(params[:id])
    @old_testament_books = reading_log.ordered_books.in_old_testament
    @new_testament_books = reading_log.ordered_books.in_new_testament
  end
end
