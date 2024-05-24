# frozen_string_literal: true

class PageHeaderComponent < ViewComponent::Base
  renders_one :right_content
  erb_template <<-ERB
    <div class="mb-6">
      <div class="flex justify-between items-center mb-2">
        <%= render(HeadingComponent.new(title: @title)) %>
        <%= right_content %>
      </div>
      <% if @description.present? %>
        <p class="<%= 'mt-4' if @description_margin %> text-lg"><%= @description %></p>
      <% end %>
    </div>
  ERB

  def initialize(title:, description: nil, description_margin: false)
    @title = title
    @description = description
    @description_margin = description_margin
  end
end
