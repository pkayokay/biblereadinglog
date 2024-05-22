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
        <p><%= @description %></p>
      <% end %>
    </div>
  ERB

  def initialize(title:, description: nil)
    @title = title
    @description = description
  end

end
