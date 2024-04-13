class SetupUserService
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    User.transaction do
      user = User.create!(email: @email, password: @password)
      ReadingLog.create!(user: user)
    rescue => e
      return { error: e.message }
    end

    {
      success: true,
      email: @email,
      password: @password,
    }
  end
end