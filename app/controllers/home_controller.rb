class HomeController < ApplicationController
  def index
    @posts = 'luanjams'
  end

  def profile
    @user = User.where('lower(username) = ?', params[:username].downcase).first 
    if @user

      @posts = Post.where(user: @user).order(created_at: :desc).limit(20)

    else
      render :profile_not_find
    end
  end
end
