# frozen_string_literal: true

class SideFormWrapperComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="mt-4 border-bottom pb-4 <%= @custom_class %>">
      <div class="mb-2">
        <h3 class="fw-medium"><%= @title %></h3>
        <p class="text-base"><%= @description %></p>
      </div>
      <div>
        <%= content %>
      </div>
    </div>
  ERB
  def initialize(title:, description:, custom_class: "")
    @title = title
    @description = description
    @custom_class = custom_class
  end

end
