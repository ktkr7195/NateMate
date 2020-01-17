class MicropostsController < ApplicationController
    before_action :authenticate_user!,only:[:new,:create,:destroy,:index]
    before_action :correct_user,only:[:destroy]

    def new
      @microposts = current_user.microposts.build if user_signed_in?
    end

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          redirect_to current_user, notice:"投稿しました！"
        else
          flash.now[:alert]='投稿に失敗しました'
          @followimg_users_feed=[]
          @feed=[]
          redirect_to new_micropost_path
        end
    end

    def show
      @post = Micropost.find(params[:id])
      require 'exifr/jpeg'
      @exif = EXIFR::JPEG.new(Rails.root.to_s+"/public/#{@post.picture.url}")
      @lat = @exif.gps_latitude.to_f
      @lng = @exif.gps_longitude.to_f
    end

    def index
    end



    def destroy
      @micropost.destroy
      redirect_to request.referrer || root_url, notice:"投稿を削除しました"
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
