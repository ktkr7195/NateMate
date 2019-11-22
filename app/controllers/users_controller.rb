class UsersController < ApplicationController
  before_action :authenticate_user!,only:[:show,:create,:update,:edit,:destroy]

  def show
    @user=User.find(params[:id])
    @this_user_all_posts=@user.microposts
    @microposts=@this_user_all_posts.page(params[:page]).per(3)
  end
end
