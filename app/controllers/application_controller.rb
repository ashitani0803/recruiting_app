class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def user_login?
        redirect_to root_path unless user_signed_in?
    end

    def find_current_user
        @user = current_user
    end

    protected

    def after_sign_in_path_for(resource)
        if current_user.authority_status == "admin"
            admin_path(current_user.company)
        else
            recruits_path
        end
        
    end

    def after_sign_out_path_for(resource)
        root_path
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :sex, :birth_year, :birth_month, :birth_day])
    end

    
end
