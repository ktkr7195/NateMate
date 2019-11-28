class MicropostsController < ApplicationController
    before_action :authenticate_user!,only:[:new,:create,:destroy]
    before_action :correct_user,only:[:destroy]

    def new
      @microposts = current_user.microposts.build if user_signed_in?
    end

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          flash[:notice] = "コレクトしました！"
          redirect_to current_user
        else
          flash[:notice]='コレクトに失敗しました'
          @followimg_users_feed=[]
          @feed=[]
          redirect_to new_micropost_path
        end
      end

    def index
    end

      def destroy
        @micropost.destroy
        flash[:success] = "コレクションを削除しました"
        redirect_to request.referrer || root_url
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
