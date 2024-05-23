# frozen_string_literal: true

class PageActionsHeaderComponent < ViewComponent::Base
  renders_one :right_content

  erb_template <<-ERB
    <div class="-mt-3 sm:mt-0 mb-8 mx-auto flex items-center justify-between">
      <%= link_to @path, class: "-ml-4 round-link"  do %>
        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-left"><path d="m12 19-7-7 7-7"/><path d="M19 12H5"/></svg>
        <span class="sr-only"><%= @title %></span>
      <% end %>
      <%= right_content %>
    </div>
  ERB

  def initialize(title: "Back", path:)
    @title = title
    @path = path
  end
end
