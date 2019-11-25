class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

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
