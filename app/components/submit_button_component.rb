# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= @form.submit @title, data: @data, class: "btn btn--primary " + @custom_classes %>
  ERB

  def initialize(title:, form:, data: {}, custom_classes: "")
    @title = title
    @form = form
    @custom_classes = custom_classes
    @data = data
  end
end
