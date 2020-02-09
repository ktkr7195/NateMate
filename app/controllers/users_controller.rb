class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]

  def show
    @user = User.find(params[:id])
    @feed = @user.microposts.page(params[:page])
    @following_users = @user.following.page(params[:page])
    @followers = @user.followers.page(params[:page])
    @liking_posts = @user.like_microposts.page(params[:page])

    #jsリクエストなら
    return unless request.xhr?
    #renderするjsファイル振り分け
    case params[:type]
    when 'post_list', 'follower_list', 'following_list', 'liking_list'
      render "shared/#{params[:type]}"
    end
  end

  def index
    return unless request.xhr?

    case params[:type]
    when 'user_list'
      render "shared/#{params[:type]}"
    end
  end
end
