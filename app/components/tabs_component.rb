# frozen_string_literal: true

class TabsComponent < ViewComponent::Base
  def initialize(items: [])
    @items = items
  end
end
