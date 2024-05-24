# frozen_string_literal: true

class TabsComponent < ViewComponent::Base
  def initialize(items: [], is_center: false, is_full_width: false, custom_classes: "")
    @items = items
    @is_center = is_center
    @is_full_width = is_full_width
    @custom_classes = custom_classes
  end
end
