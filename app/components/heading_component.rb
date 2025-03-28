class HeadingComponent < ViewComponent::Base
  erb_template <<-ERB
    <h1 class="text-3xl font-bold"><%= @title %></h1>
  ERB

  def initialize(title:)
    @title = title
  end
end
