# frozen_string_literal: true

class LabelComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= @form.label @for_attribute, @title, class: "opacity-70 block font-medium text-sm" %>
  ERB

  def initialize(for_attribute:, form:, title: nil)
    @form = form
    @for_attribute = for_attribute
    @title = title
  end
end