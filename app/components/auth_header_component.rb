# frozen_string_literal: true

class AuthHeaderComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="text-center flex justify-center flex-col items-center mb-5 space-y-2">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="#333" class="w-10 h-10">
        <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 3.75V16.5L12 14.25 7.5 16.5V3.75m9 0H18A2.25 2.25 0 0 1 20.25 6v12A2.25 2.25 0 0 1 18 20.25H6A2.25 2.25 0 0 1 3.75 18V6A2.25 2.25 0 0 1 6 3.75h1.5m9 0h-9" />
      </svg>
      <h1 class="text-4xl font-bold"><%= @title %></h1>
      <h2 class="text-2xl font-medium"><%= @subtitle %></h1>
    </div>
  ERB

  def initialize(title:, subtitle:)
    @title = title
    @subtitle = subtitle
  end
end
