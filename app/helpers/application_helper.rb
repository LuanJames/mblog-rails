module ApplicationHelper

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=128&d=mm"
  end

    # button#toggle-follow.btn.btn-block class="#{@btn_follow ? 'btn-primary' : 'btn-default'}"data-user==@user.id
    #     = @btn_follow ? t('view.follow') : t('view.unfollow')

  def btn_follow(user, classes = '')
    if !user_signed_in? or current_user != user
      has_btn_follow = true

      if user_signed_in?
        has_btn_follow = !current_user.following.include?(user)
      else
        has_btn_follow = true
      end
      
      btn_class = has_btn_follow ? 'btn-primary' : 'btn-default';
      content_tag(:button, :class => "toggle-follow btn #{btn_class} #{classes}", 'data-user' => user.id) do
        has_btn_follow ? t('view.follow') : t('view.unfollow')
      end
    end
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
