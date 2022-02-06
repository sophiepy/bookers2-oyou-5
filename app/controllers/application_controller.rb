class ApplicationController < ActionController::Base
before_action :authenticate_user!, except: [:top, :about]
# before_action :configure_permitted_parameters, if: :devise_
before_action :configure_permitted_parameters, if: :devise_controller?

# def index
    # flash[:notice] = "ログイン済ユーザーのみ記事の詳細を確認できます" unless user_signed_in?
  # end


  def after_sign_in_path_for(resource)
    user_path(current_user.id)
    # root_path
  end

  # def after_sign_out_path_for(resource)
  #   root_path
  # end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
