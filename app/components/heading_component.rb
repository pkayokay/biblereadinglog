# frozen_string_literal: true

class HeadingComponent < ViewComponent::Base
  erb_template <<-ERB
    <h1 class="text-3xl sm:text-4xl font-semibold"><%= @title %></h1>
  ERB

  def initialize(title:)
    @title = title
  end
end
