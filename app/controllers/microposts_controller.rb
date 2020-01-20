class MicropostsController < ApplicationController
    before_action :authenticate_user!,only:[:new,:create,:destroy,:index]
    before_action :correct_user,only:[:destroy]

    def new
      @micropost = current_user.microposts.build if user_signed_in?
    end

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          redirect_to current_user, notice:"投稿しました！"
        else
          flash.now[:alert]='投稿に失敗しました'
          @followimg_users_feed=[]
          @feed=[]
          render 'microposts/new'
        end
    end

    def show
      @micropost = Micropost.find(params[:id])
      @this_post_liking_users = @micropost.like_users.page(params[:page])
      require 'exifr/jpeg'
      if Rails.env == 'production'
        @exif = EXIFR::JPEG.new(open(@micropost.picture.url))
      else
        @exif = EXIFR::JPEG.new(Rails.root.to_s+"/public/#{@micropost.picture.url}")
      end

      @lat = @exif.gps_latitude.to_f
      @lng = @exif.gps_longitude.to_f
    end

    def index
    end



    def destroy
      @micropost.destroy
      redirect_to current_user
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end


    private

      def micropost_params
        params.require(:micropost).permit(:title,:content,:picture)
      end


end
