class StaticPagesController < ApplicationController
  def home
    @feed = Micropost.all.page(params[:page]).per(6)
    return unless user_signed_in?

    @following_users_feed = current_user.following_users_feed.page(params[:page]).per(6)
  end

  def contact
  end
end
