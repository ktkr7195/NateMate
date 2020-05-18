class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :correct_user, only: [:destroy]

  def new
    @micropost = current_user.microposts.build if user_signed_in?
  end

  #
  # 新規投稿を行う
  # get_exifで投稿された画像のexif情報を取得する
  # @param [Object] micropost 新規の投稿
  # @param [Float] @lat, @lng get_exifで取得したexif情報の緯度と経度
  #
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      get_exif(@micropost) if @micropost.exif_is_valid == true && @micropost.address.blank?
      @micropost.update_attributes(latitude: @lat, longitude: @lng) if @lat && @lng
      redirect_to current_user
    else
      @followimg_users_feed = []
      @feed = []
      render 'microposts/new'
    end
  end

  #
  # 投稿の詳細を表示する
  # @param [Object] micropost 投稿
  # @param [Object] this_post_liking_users 投稿をいいねしているユーザーの一覧
  #
  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.order(created_at: :desc).page(params[:page]).per(10)
    @comment = Comment.new
    @this_post_liking_users = @micropost.like_users.page(params[:page])
  end

  def index

  end

  def destroy
    @micropost.destroy
    redirect_to current_user
  end

  private

  #
  # 投稿を削除する際にbefore_actionで削除権限があるか判定するためのメソッド
  # ユーザーがadmin権限を持っているか、投稿がユーザー自身の投稿であるかで分岐を行う
  # @param [Object] 削除対象の投稿
  # @return @micropost admin権限があれば全ての投稿に対して削除権限を持つ
  # @return @micropost ユーザー自身の投稿にのみ削除権限を持つ
  # @redirect root 上記いずれでもない場合にトップページへリダイレクトさせる
  #
  def correct_user
    if current_user.admin
      @micropost = Micropost.find_by(id: params[:id])
    else
      @micropost = current_user.microposts.find_by(id: params[:id])
    end
    redirect_to root_url if @micropost.nil?
  end

  def micropost_params
    params.require(:micropost).permit(:title, :content, :picture, :exif_is_valid,
                                      :address, :latitude, :longitude)
  end
end
