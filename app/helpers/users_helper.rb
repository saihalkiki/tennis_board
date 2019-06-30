module UsersHelper

  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user, options = { size: 80 })
    email_hash = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{email_hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
