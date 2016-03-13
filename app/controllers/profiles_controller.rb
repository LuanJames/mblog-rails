class ProfilesController < ApplicationController
  before_action :check_autenticate_json, only: [:create_post, :toggle_follow_user]
  def index
    @user = User.where('lower(username) = ?', params[:username].downcase).first 
    if @user

      @posts = Post.where(user: @user).order(created_at: :desc).limit(20)

    else
      render :not_find
    end
  end

  def create_post
    if params[:content].present?
      @post = Post.create(user: current_user, content: params[:content])
      html = render_to_string('_post_item', layout: false)
      render json: {success: true, body: @post, html: html}, status: 201 and return
    end
    render json: {success: false}, status: 400
  end

  def toggle_follow_user
    if params[:user_id].present?

      if User.exists? params[:user_id]
        user = User.find(params[:user_id])

        if Relationship.delete_all(from_id: current_user.id, to_id: user.id) > 0
          render json: {success: true, body: I18n.t('controller.profiles.follow')}, status: 201 and return
        else
          current_user.following << user
          render json: {success: true, body: I18n.t('controller.profiles.unfollow')}, status: 201 and return
        end
      end

    end
    render json: {success: false}, status: 400
  end

  private
    def check_autenticate_json
      unless current_user
        render json: {success: false}, status: 401 and return
      end 
    end
end
