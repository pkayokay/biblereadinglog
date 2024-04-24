# frozen_string_literal: true

class FormWrapperComponent < ViewComponent::Base
  renders_one :footer

  erb_template <<-ERB
    <div class="max-w-[400px] mx-auto">
      <%= content %>
      <% if footer %>
        <div class="text-center mt-4">
          <%= footer %>
        </div>
      <% end %>
    </div>
  ERB
end


