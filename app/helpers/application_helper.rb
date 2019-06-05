module ApplicationHelper
  def set_stars(rating)
    result = ""
    for i in 1..5
      if i > rating
        result << '<span><i class="far fa-star"></i></span>'
      else
        result << '<span><i class="fas fa-star"></i></span>'
      end
    end
    return result.html_safe
  end

  def user_avatar(user)
    if user.avatar.url.blank?
      image_path 'geek.jpg'
    else
      user.avatar
    end
  end
end
