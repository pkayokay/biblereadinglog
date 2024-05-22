# frozen_string_literal: true

class AuthFormContainerComponent < ViewComponent::Base
  renders_one :footer

  erb_template <<-ERB
    <div class="w-full max-w-[410px] mx-auto">
      <%= content %>
      <% if footer %>
        <div class="text-center mt-4 flex flex-col space-y-3 items-center">
          <%= footer %>
        </div>
      <% end %>
    </div>
  ERB
end


