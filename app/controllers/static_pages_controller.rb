class StaticPagesController < ApplicationController
  include MicropostsHelper
  def home
    @feed = Micropost.all.page(params[:page])
    return unless user_signed_in?

    @following_users_feed = current_user.following_users_feed.page(params[:page])
    @current_user_post = Micropost.where(user_id: current_user.id).where(exif_is_valid: true)
    @post_json_data = @current_user_post.to_json(only: [:id, :title, :picture, :latitude, :longitude])

    return unless request.xhr?

    case params[:type]
    when 'new_post_list', 'friendly_post_list'
      render "shared/#{params[:type]}"
    end
  end

  def contact
  end
end
