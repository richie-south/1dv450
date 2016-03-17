class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    private
    helper_method :current_user, :is_admin

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def is_admin?
        @isAdmin = @current_user.isAdmin
    end

    def require_login
        if current_user.nil? then
            redirect_to root_path
        end
    end

end
