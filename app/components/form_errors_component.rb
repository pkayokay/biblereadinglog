# frozen_string_literal: true

class FormErrorsComponent < ViewComponent::Base
  def initialize(form:)
    @form = form
  end


  erb_template <<-ERB
    <% if @form.object.errors.any? %>
      <div class="text-sm bg-red-50 text-red-700 mb-4 px-5 py-4 rounded">
        <% if @form.object.errors.one? %>
          <p class="font-medium">You have an error:</p>
        <% else %>
          <p class="font-medium">You have some errors:</p>
        <% end %>
        <ul class="list-disc list-inside mt-1">
          <% @form.object.errors.full_messages.each do |message| %>
            <li class="pl-3"><%= message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>
  ERB
end
