class CardWrapperComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="px-5 sm:px-8 <%= request.path == root_path ? 'pt-8' : 'py-8' %> <%= @custom_classes %> flex-1 relative bg-white border-0 sm:border border-gray-200 sm:shadow-xs sm:rounded-lg mx-auto w-full max-w-2xl">
      <%= content %>
    </div>
  ERB

  def initialize(custom_classes: "")
    @custom_classes = custom_classes
  end
end
