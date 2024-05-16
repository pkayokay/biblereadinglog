# frozen_string_literal: true

class BackButtonComponent < ViewComponent::Base
  renders_one :middle_content
  renders_one :right_content

  erb_template <<-ERB
    <div class="mt-8  mb-8 mx-auto max-w-2xl w-full flex items-center justify-between px-4 sm:px-0">
      <%= link_to @path, class: "inline-flex items-center space-x-1 text-base hover:underline"  do %>
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-left"><path d="m15 18-6-6 6-6"/></svg>
        <span><%= @title %></span>
      <% end %>
      <% if middle_content %>
        <div class="absolute text-center -translate-x-1/2 left-1/2 top-4">
          <%= middle_content %>
        </div>
      <% end %>
      <%= right_content %>
    </div>
  ERB

  def initialize(title: "Back", path:, include_margin: false)
    @title = title
    @path = path
    @include_margin = include_margin
  end

end
