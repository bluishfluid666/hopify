module UsersHelper
  def gravatar_for(user, size = 20)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  def avatar_for(user, size = 50, css_class="")
    if user.avatar?
      image_tag user.avatar.url(:thumb), height: size, width: size, class: css_class
    else
      gravatar_for(user, size)
    end
  end
end
