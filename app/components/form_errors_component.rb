# frozen_string_literal: true

class FormErrorsComponent < ViewComponent::Base
  def initialize(form:)
    @form = form
  end


  erb_template <<-ERB
    <% if @form.object.errors.any? %>
      <div class="text-sm border border-red-200 bg-red-100 text-red-800 mb-4 px-4 py-3 rounded">
        <% if @form.object.errors.one? %>
          <p class="font-medium">You have an error:</p>
        <% else %>
          <p class="font-medium">You have some errors:</p>
        <% end %>
        <ul class="list-disc list-inside">
          <% @form.object.errors.full_messages.each do |message| %>
            <li><%= message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>
  ERB
end
