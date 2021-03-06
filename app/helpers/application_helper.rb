module ApplicationHelper
  def gravatar_for(user, options = { size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded-circle")
  end

  def paginate(collection:)
    will_paginate collection, list_classes: %w(pagination justify-content-center), previous_label: '&larr; Previous', next_label: 'Next &rarr;'
  end

  def admin_user?
    current_user && current_user.admin?
  end
end
