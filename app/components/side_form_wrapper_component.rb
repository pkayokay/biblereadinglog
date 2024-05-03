# frozen_string_literal: true

class SideFormWrapperComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="mt-6 border-b pb-8 mb-8 flex md:flex-row flex-col <%= @custom_class %>">
      <div class="w-[240px] mb-3 pr-4">
        <h3 class="mb-1 text-xl font-medium"><%= @title %></h3>
        <p class="opacity-60 text-base"><%= @description %></p>
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
