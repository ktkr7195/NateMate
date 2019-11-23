class UsersController < ApplicationController
  before_action :authenticate_user!,only:[:show,:create,:update,:edit,:destroy,
                                          :index,:followers,:following]

  def show
    @user=User.find(params[:id])
    @this_user_all_posts=@user.microposts
    @microposts=@this_user_all_posts.page(params[:page]).per(3)
  end

  def index
    @users=User.all
  end

  def following
    @title='フォローされているユーザー'
    @user=User.find(params[:id])
    @users=@user.following.page(params[:page])
    render'show_follow'
  end

  def followers
    @title='フォロー中のユーザー'
    @user=User.find(params[:id])
    @users=@user.followers.page(params[:page])
    render'show_follow'
  end
end
