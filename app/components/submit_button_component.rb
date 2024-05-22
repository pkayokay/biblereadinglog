# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  erb_template <<-ERB
    <%= @form.submit @title, class: "btn btn--primary" %>
  ERB

  def initialize(title:, form:)
    @title = title
    @form = form
  end

end
