# frozen_string_literal: true

class BackButtonComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= link_to @path, class: "text-base hover:underline" do %>
      &larr; <%= @title  %>
    <% end %>
  ERB

  def initialize(title: "Back", path:)
    @title = title
    @path = path
  end

end
