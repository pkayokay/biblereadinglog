# frozen_string_literal: true

class BackButtonComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= link_to @path, class: "inline-flex items-center space-x-1 text-base hover:underline " + (@include_margin ? 'mb-9' : '')  do %>
      <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-left"><path d="m15 18-6-6 6-6"/></svg>
      <span><%= @title %></span>
    <% end %>
  ERB

  def initialize(title: "Back", path:, include_margin: false)
    @title = title
    @path = path
    @include_margin = include_margin
  end

end
