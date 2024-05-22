# frozen_string_literal: true

class EmptyStateComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="bg-stone-50/50 pt-14 pb-14 px-4 rounded-lg text-lg text-center border rounded-lg border-dashed">
      <p class="text-lg opacity-40"><%= @message %></p>
      <%= content %>
    </div>
  ERB

  def initialize(message:)
    @message = message
  end
end
