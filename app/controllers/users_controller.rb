class UsersController < ApplicationController
  before_action :authenticate_user!,only:[:show,:index,:followers,:following]

  def show
    @user=User.find(params[:id])
    @this_user_all_posts=@user.microposts
    @microposts=@this_user_all_posts.page(params[:page]).per(3)
    @following_users=@user.following.page(params[:page])
    @followers=@user.followers.page(params[:page])
  end

  def index
    @users=User.all
  end

  def following
    @title='フォロー中'
    @page_title='フォローされているユーザー'
    @user=User.find(params[:id])
    @users=@user.following.page(params[:page])
    render'show_follow'
  end

  def followers
    @title='フォロー'
    @page_title='フォロー中のユーザー'
    @user=User.find(params[:id])
    @users=@user.followers.page(params[:page])
    render'show_follow'
  end
end
