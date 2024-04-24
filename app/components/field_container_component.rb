# frozen_string_literal: true

class FieldContainerComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="mb-4 <%= @custom_classes %>">
      <%= content %>
    </div>
  ERB

  def initialize(custom_classes: "")
    @custom_classes = custom_classes
  end
end
