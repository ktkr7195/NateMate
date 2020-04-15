class ApplicationController < ActionController::Base
  include MicropostsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  #
  # 記事検索、ユーザー検索の初期設定
  # @param [Array] search_count 記事検索結果件数を求める際に対象とする配列
  # @param [Array] search_feeds 記事検索結果
  # @param [Array] user_search_feeds ユーザー検索結果
  #
  def set_search
    @key = Micropost.ransack(params[:q])
    @search_count = @key.result(distinct: true)
    @search_feeds = @key.result(distinct: true).page(params[:page])
    @user_key = User.ransack(params[:q])
    @user_search_feeds = @user_key.result(distinct: true).page(params[:page])
  end

  protected

  #
  # 新規登録、ログイン後のリダイレクト先を設定
  #
  def after_sign_in_path_for(_resource)
    current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,          keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up,          keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update,   keys: [:name])
    devise_parameter_sanitizer.permit(:account_update,   keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update,   keys: [:remove_avatar])
  end
end
