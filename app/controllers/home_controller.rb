class HomeController < ApplicationController
  def index
    @last_posts = Post.all.order(created_at: :desc).limit(20)

    @suggestions = User.all
    if user_signed_in?
      @suggestions = @suggestions.where('id != ?', current_user.id)
    end

    @suggestions = @suggestions.sample(3)

  end
end
