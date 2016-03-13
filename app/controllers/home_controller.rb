class HomeController < ApplicationController
  def index
    @last_posts = Post.all.order(created_at: :desc).limit(20)
  end
end
