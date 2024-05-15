class BooksController < ApplicationController
  before_action :set_book

  def show
    add_breadcrumb(@reading_log.name, reading_log_path(@reading_log))
    add_breadcrumb(@book.name)
  end

  def pin_book
    @pin_order_value = if @book.pin_order.present?
      nil
    else
      last_pinned_book = @reading_log.books.pinned.order(pin_order: :desc).first
      if last_pinned_book.present?
        last_pinned_book.pin_order + 1
      else
        0
      end
    end

    if @book.update(pin_order: @pin_order_value)
      @has_pending_status = params[:status] == "pending"
      @has_completed_status = params[:status] == "completed"
      @has_no_status = params[:status].blank?

      if @has_pending_status
        unpinned_ordered_books = @reading_log.ordered_books.pending.unpinned
        @has_pinned_books = @reading_log.books.pending.pinned.exists?
      elsif @has_completed_status
        unpinned_ordered_books = @reading_log.ordered_books.complete.unpinned
        @has_pinned_books = @reading_log.books.complete.pinned.exists?
      else
        unpinned_ordered_books = @reading_log.ordered_books.unpinned
        @has_pinned_books = @reading_log.books.pinned.exists?
      end
      @has_unpinned_books = unpinned_ordered_books.present?

      if @pin_order_value.present?
        flash.now[:notice] = "#{@book.name} starred!"
      else
        flash.now[:notice] = "#{@book.name} unstarred!"

        if unpinned_ordered_books.present?
          current_book_index = unpinned_ordered_books.index(@book)

          if current_book_index.present? && current_book_index != 0
            @prev_book = unpinned_ordered_books[current_book_index-1]
          end
        end
      end

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
      if @book.completed_at_previously_changed?
        if @book.completed_at.present?
          @completed_status = "complete"
          flash.now[:notice] = "Congrats, you finished the book! 🎉"
        else
          @completed_status = "incomplete"
        end
      end
    else
      flash.now[:alert] = "Sorry, something went wrong."
    end
  end

  private

  def set_book
    @reading_log = current_user.reading_logs.find(params[:reading_log_id])
    @book = @reading_log.books.find(params[:id])
  end

  def has_pending_status?
    params[:status] == "pending"
  end
end
