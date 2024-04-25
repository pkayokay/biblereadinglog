class SetupUserService
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    User.transaction do
      @user = User.create!(email: @email, password: @password)
      @reading_log = ReadingLog.create!(user: @user)
      @books_result = BuildBooksService.new(reading_log: @reading_log).call

      if @books_result[:error].present?
        return { error: @books_result[:error]  }
      end
    rescue => e
      return { error: e.record.errors.full_messages.first }
    end

    {
      data: {
        user: @user,
        reading_log: @reading_log,
        books: @books_result[:data]
      },
      success: true,
    }
  end
end