class StaticPagesController < ApplicationController

  def home
    @all_users_feed=Micropost.all.page(params[:page])
  end

  def contact
  end
end
