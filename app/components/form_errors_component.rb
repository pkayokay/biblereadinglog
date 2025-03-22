class FormErrorsComponent < ViewComponent::Base
  def initialize(errors: [])
    @errors = errors
  end

  erb_template <<-ERB
    <% if @errors.present? %>
      <div class="flex items-center text-base bg-red-100 mb-4 pl-4 pr-5 py-4 rounded-lg">
        <div class="w-[20px] mr-4">
          <svg class="stroke-red-700" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-x"><circle cx="12" cy="12" r="10"/><path d="m15 9-6 6"/><path d="m9 9 6 6"/></svg>
        </div>
        <span class="text-red-800"><%= @errors.full_messages.to_sentence %>.</span>
      </div>
    <% end %>
  ERB
end
