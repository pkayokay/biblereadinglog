# frozen_string_literal: true

class AccountFormWrapperComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="mt-6 border-b pb-8 mb-8 flex flex-col <%= @custom_class %>">
      <div class="mb-2">
        <h3 class="text-xl font-bold"><%= @title %></h3>
        <p class="text-base"><%= @description %></p>
      </div>
      <div class="flex-1">
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
