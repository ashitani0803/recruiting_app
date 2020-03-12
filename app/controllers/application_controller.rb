class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def user_login?
        if !user_signed_in?
            flash[:alert] = "ログインしてください。"
            redirect_to root_path unless user_signed_in?
        end
    end

    def find_current_user
        @user = current_user
    end

    protected

    def after_sign_in_path_for(resource)
        if current_user.authority_status == "admin"
            admin_path(current_user.company)
        elsif current_user.phone_number.present? || current_user.educational_background.present? || current_user.work_experience.present? || current_user.introduction.present?
            recruits_path
        else
            edit_user_path(current_user)
        end
    end

   

    def after_sign_out_path_for(resource)
        root_path
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :sex, :birth_year, :birth_month, :birth_day, :email, :password])
    end

    
end
