class SetupUserService
  def initialize(email:, password: nil)
    @email = email
    @password = password
  end

  def call
    User.transaction do
      @password_value = @password || SecureRandom.hex(6)
      user = User.create!(email: @email, password: @password_value)
      ReadingLog.create!(user: user)
    rescue => e
      return { error: e.message }
    end

    {
      success: true,
      email: @email,
      password: @password_value,
    }
  end
end