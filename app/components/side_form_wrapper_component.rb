# frozen_string_literal: true

class SideFormWrapperComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="mt-6 flex md:flex-row flex-col">
      <div class="w-[280px] mb-3">
        <h3 class="text-xl font-semibold"><%= @title %></h3>
        <p class="opacity-60 text-sm"><%= @description %></p>
      </div>
      <div class="flex-1">
        <%= content %>
      </div>
    </div>
  ERB
  def initialize(title:, description:)
    @title = title
    @description = description
  end

end
