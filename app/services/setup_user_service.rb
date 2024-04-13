class SetupUserService
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    User.transaction do
      @user = User.create!(email: @email, password: @password)
      @reading_log = ReadingLog.create!(user: @user)
      @books = CreateBooksService.new(reading_log: @reading_log).call
    rescue => e
      return { error: e.record.errors.full_messages.first }
    end

    {
      data: {
        user: @user,
        reading_log: @reading_log,
        books: @books[:data]
      },
      success: true,
    }
  end
end