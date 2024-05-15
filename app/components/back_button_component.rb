# frozen_string_literal: true

class BackButtonComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= link_to @path, class: "inline-block text-base hover:underline " + (@include_margin ? 'mb-7' : '')  do %>
      &larr; <%= @title  %>
    <% end %>
  ERB

  def initialize(title: "Back", path:, include_margin: false)
    @title = title
    @path = path
    @include_margin = include_margin
  end

end
