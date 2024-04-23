class BooksController < ApplicationController
  before_action :set_book

  def show
  end

  def toggle_chapter
    @chapter_number = params[:chapter_number].to_i

    chapters_data = @book.chapters_data
    @chapter_to_update = chapters_data.find { |chapter| chapter["chapter_number"] == @chapter_number}

    if @chapter_to_update
      if @chapter_to_update["completed_at"].present?
        @chapter_to_update["completed_at"] = nil
      else
        @chapter_to_update["completed_at"] = Time.zone.now
      end
    end

    if @book.update(chapters_data: chapters_data)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      flash[:alert] = "Sorry, something went wrong."

      redirect_to root_path
    end
  end

  private

  def set_book
    reading_log = current_user.reading_logs.find(params[:reading_log_id])
    @book = reading_log.books.find(params[:id])
  end
end
