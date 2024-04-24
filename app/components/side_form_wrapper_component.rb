# frozen_string_literal: true

class SideFormWrapperComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="border rounded-lg bg-white p-6 mt-8 flex md:flex-row flex-col <%= @custom_class %>">
      <div class="w-[360px] mb-3">
        <h3 class="text-xl font-medium"><%= @title %></h3>
        <p class="opacity-60 text-sm"><%= @description %></p>
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
