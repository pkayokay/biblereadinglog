class CardComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="border rounded-lg bg-white p-6 <%= @custom_classes %>">
      <%= content %>
    </div>
  ERB

  def initialize(custom_classes: "")
    @custom_classes = custom_classes
  end
end
