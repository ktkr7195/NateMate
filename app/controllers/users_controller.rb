class UsersController < ApplicationController
  before_action :authenticate_user!,only:[:show,:index]

  def show
    @user=User.find(params[:id])
    @this_user_all_posts=@user.microposts
    @feed=@this_user_all_posts.page(params[:page]).per(9)
    @following_users=@user.following.page(params[:page])
    @followers=@user.followers.page(params[:page])
    @liking_posts=@user.like_microposts.page(params[:page])
  end

  def index
    @users=User.all
  end
end
