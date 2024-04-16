# frozen_string_literal: true

class HeadingComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
