class BooksController < ApplicationController
  before_action :set_book

  def show
  end

  def pin_book
    @pin_order_value = if @book.pin_order.present?
      nil
    else
      last_pinned_book = @reading_log.books.where.not(pin_order: nil).order(pin_order: :desc).first
      if last_pinned_book.present?
        last_pinned_book.pin_order + 1
      else
        0
      end
    end

    if @book.update(pin_order: @pin_order_value)
      flash.now[:notice] = "#{@book.name} #{@pin_order_value.nil? ? 'unpinned' : 'pinned'}!"

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to reading_log_path(@reading_log) }
      end
    else
      flash[:alert] = "Sorry, something went wrong."
      redirect_to reading_log_path(@reading_log)
    end
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
        format.html { redirect_to reading_log_path(@reading_log) }
      end
    else
      flash[:alert] = "Sorry, something went wrong."
      redirect_to reading_log_path(@reading_log)
    end
  end

  private

  def set_book
    @reading_log = current_user.reading_logs.find(params[:reading_log_id])
    @book = @reading_log.books.find(params[:id])
  end
end
