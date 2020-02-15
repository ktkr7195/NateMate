class UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :authenticate_user!, only: %i[show index]

  def show
    @user = User.find(params[:id])
    @feed = @user.microposts.page(params[:page])
    @following_users = @user.following.page(params[:page])
    @followers = @user.followers.page(params[:page])
    @liking_posts = @user.like_microposts.page(params[:page])
    @user_post = Micropost.where(user_id: @user.id,exif_is_valid: true).where.not(latitude: nil).or \
                (Micropost.where(user_id: @user.id).where.not(address: nil,latitude: nil))
    @post_json_data = @user_post.to_json(only: %i[id title picture latitude longitude])

    # jsリクエストで通過
    return unless request.xhr?
    # render振り分け
    case params[:type]
    when 'post_list', 'follower_list', 'following_list', 'liking_list'
      render "shared/#{params[:type]}"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to current_user
  end

  def index
    return unless request.xhr?

    case params[:type]
    when 'user_list'
      render "shared/#{params[:type]}"
    end
  end


  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
