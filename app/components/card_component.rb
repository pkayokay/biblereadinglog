# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="border rounded-lg bg-white p-6">
      <%= content %>
    </div>
  ERB
end
