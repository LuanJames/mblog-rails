class ProfilesController < ApplicationController
  def index
    @user = User.where('lower(username) = ?', params[:username].downcase).first 
    if @user

      @posts = Post.where(user: @user).order(created_at: :desc).limit(20)

    else
      render :not_find
    end
  end
end
