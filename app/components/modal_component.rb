class ModalComponent < ViewComponent::Base
  erb_template <<-ERB
    <div data-controller="modal" data-modal-open-value="true">
      <dialog data-modal-target="dialog" class="w-[92%] sm:w-full max-w-xl p-6 xs:p-8 rounded-lg backdrop:bg-black/60 relative">
        <button data-action="modal#close" class="p-2 opacity-80 text-sm rounded-sm absolute right-2.5 top-2.5">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
          <span class="sr-only">Close</span>
        </button>
        <div class="mb-5">
          <h1 class="text-2xl font-bold">
            <%= @title %>
          </h1>
        </div>
        <%= content %>
      </dialog>
    </div>
  ERB

  def initialize(title:)
    @title = title
  end
end
