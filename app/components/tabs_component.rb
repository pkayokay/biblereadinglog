# frozen_string_literal: true

class TabsComponent < ViewComponent::Base
  def initialize(items: [], is_center: false)
    @items = items
    @is_center= is_center
  end
end
