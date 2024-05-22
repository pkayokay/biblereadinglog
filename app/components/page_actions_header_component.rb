# frozen_string_literal: true

class PageActionsHeaderComponent < ViewComponent::Base
  renders_one :right_content

  erb_template <<-ERB
    <div class="mb-8 mx-auto flex items-center justify-between">
      <%= link_to @path, class: "-ml-1 inline-flex items-center space-x-1 text-base hover:underline opacity-50 font-medium hover:opacity-100"  do %>
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-left"><path d="m15 18-6-6 6-6"/></svg>
        <span><%= @title %></span>
      <% end %>
      <%= right_content %>
    </div>
  ERB

  def initialize(title: "Back", path:)
    @title = title
    @path = path
  end
end
