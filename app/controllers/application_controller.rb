class ApplicationController < ActionController::Base
  include MicropostsHelper
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_search

  def set_search
    @key=Micropost.ransack(params[:q])
    @search_feeds=@key.result(distinct: true).page(params[:page])
    @user_key=User.ransack(params[:q])
    @user_search_feeds=@user_key.result(distinct: true).page(params[:page])
  end

    protected

    #新規登録、ログイン後のリダイレクト先を変更
    def after_sign_in_path_for(resource)
      current_user
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,           keys: [:name])
      devise_parameter_sanitizer.permit(:sign_up,           keys: [:avatar])
      devise_parameter_sanitizer.permit(:account_update,    keys: [:name])
      devise_parameter_sanitizer.permit(:account_update,    keys: [:avatar])
      devise_parameter_sanitizer.permit(:account_update,    keys: [:remove_avatar])
    end


end
