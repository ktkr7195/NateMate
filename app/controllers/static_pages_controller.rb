class StaticPagesController < ApplicationController
  include MicropostsHelper

  #
  # @param [Array] feed 全ユーザーの投稿記事
  # @param [Array] following_users_feed current_userがフォローしているユーザーの投稿記事
  # @param [Array] current_user_post current_userの投稿
  # @param [Array] post_json_data current_user_postをJSONに変換した配列
  #
  def home
    @feed = Micropost.all.page(params[:page])
    return unless user_signed_in?

    @following_users_feed = current_user.following_users_feed.page(params[:page])
    @current_user_post = Micropost.where(user_id: current_user.id,exif_is_valid: true).or \
                        (Micropost.where(user_id: current_user.id).where.not(address: nil).where.not(latitude: nil))
    @post_json_data = @current_user_post.to_json(only: %i[id title picture latitude longitude])
    # jsリクエストなら通過
    return unless request.xhr?

    case params[:type]
    when 'new_post_list', 'friendly_post_list'
      render "shared/#{params[:type]}"
    end
  end

  def contact
  end
end
