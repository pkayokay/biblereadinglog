# frozen_string_literal: true

class TabsComponent < ViewComponent::Base
  def initialize(items: [], is_center: false, is_full_width: false)
    @items = items
    @is_center= is_center
    @is_full_width = is_full_width
  end
end
