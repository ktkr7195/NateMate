class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]

  def show
    @user = User.find(params[:id])
    @feed = @user.microposts.page(params[:page]).per(9)
    @following_users = @user.following.page(params[:page]).per(8)
    @followers = @user.followers.page(params[:page]).per(8)
    @liking_posts = @user.like_microposts.page(params[:page]).per(9)
  end

  def index
  end
end
