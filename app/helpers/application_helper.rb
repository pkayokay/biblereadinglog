module ApplicationHelper
  def marketing_site_title
    "Bible Reading Log | A simple Bible reading tracker"
  end

  def marketing_site_description
    "A simple Bible reading tracker"
  end

  def is_auth_path?
    %w[sessions registrations passwords confirmations].include?(controller_name)
  end
end
