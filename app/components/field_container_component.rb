# frozen_string_literal: true

class FieldContainerComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="mb-4">
      <%= content %>
    </div>
  ERB
end
