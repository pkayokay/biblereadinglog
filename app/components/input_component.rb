# frozen_string_literal: true

class InputComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= @form.send(field_type, @id_and_name, class: "form-input", required: @required) %>
  ERB

  def initialize(form:, type:, id_and_name:, required: false)
    @form = form
    @type = type
    @id_and_name = id_and_name
    @required = required
  end

  def field_type
    "#{@type}_field"
  end
end
