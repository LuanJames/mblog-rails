module ApplicationHelper

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=128&d=mm"
  end

  def time(post)
    sec = (Time.now - post.updated_at)
    if sec < 1.minute
      return "#{sec.to_i} #{t('view.abr.second')}"
    elsif sec < 1.hour
      return "#{sec.to_i / 60} #{t('view.abr.minute')}"
    else
      return "#{sec.to_i / 60 / 60} #{t('view.abr.hour')}"
    end
  end
end
