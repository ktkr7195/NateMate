class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :correct_user, only: [:destroy]

  def new
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      get_exif(@micropost) if @micropost.exif_is_valid == true
      if @lat && @lng
        @micropost.update_attributes(latitude: @lat, longitude: @lng)
      end
      redirect_to current_user
    else
      @followimg_users_feed = []
      @feed = []
      render 'microposts/new'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @this_post_liking_users = @micropost.like_users.page(params[:page])
  end

  def index
  end

  def destroy
    @micropost.destroy
    redirect_to current_user
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  def micropost_params
    params.require(:micropost).permit(:title, :content, :picture, :exif_is_valid)
  end
end
