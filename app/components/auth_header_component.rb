# frozen_string_literal: true

class AuthHeaderComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="text-center flex justify-center flex-col items-center mb-5 space-y-2">
      <span class="text-7xl">📚</span>
      <h1 class="text-4xl font-bold"><%= @title %></h1>
      <% if @subtitle %>
        <h2 class="text-2xl font-medium"><%= @subtitle %></h1>
      <% end %>
      <% if @description %>
        <p class="text-lg"><%= @description %></p>
      <% end %>
    </div>
  ERB

  def initialize(title:, subtitle: nil, description: nil)
    @title = title
    @subtitle = subtitle
    @description = description
  end
end
