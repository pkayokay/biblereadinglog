# frozen_string_literal: true

class LabelComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= @form.label @for_attribute, @title, class: "mb-0.5 block text-sm " + @custom_classes %>
  ERB

  def initialize(for_attribute:, form:, title: nil, custom_classes: "")
    @form = form
    @for_attribute = for_attribute
    @title = title
    @custom_classes = custom_classes
  end
end