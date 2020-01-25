class StaticPagesController < ApplicationController
  def home
    @feed=Micropost.all.page(params[:page]).per(6)
    if user_signed_in?
      @following_users_feed=current_user.following_users_feed.page(params[:page]).per(6)
    end
  end


  def contact
  end
end
