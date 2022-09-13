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
  def shop_avatar(shop, css_class="", version=:thumb)
    if shop.shop_avatar?
      image_tag shop.shop_avatar.url(version), class: css_class
    else
      image_tag "shopavt_default.svg", height: 50, width: 50, class: css_class
    end
  end
end
