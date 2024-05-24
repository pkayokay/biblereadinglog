class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Do something"
  end
end
