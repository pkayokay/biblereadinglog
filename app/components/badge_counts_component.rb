# frozen_string_literal: true

class BadgeCountsComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="mx-auto w-fit flex items-center font-medium text-base text-neutral-900 bg-stone-100  py-1 px-3 rounded-lg <%= @custom_classes %>">
      <span><%= @title %><%= @numerator %>/<%= @denominator %></span>
    </div>
  ERB


  def initialize(numerator:, denominator:, title: "", custom_classes: "")
    @numerator = numerator
    @denominator = denominator
    @title = title
    @custom_classes = custom_classes
  end
end
