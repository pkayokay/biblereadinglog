# frozen_string_literal: true

class BadgeComponent < ViewComponent::Base
  def initialize(title:, custom_classes: "")
    @title = title
    @custom_classes = custom_classes
  end

end
