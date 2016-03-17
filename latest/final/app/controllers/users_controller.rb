class UsersController < ApplicationController
    def index

    end

    def new
        @user = User.new
     end

    def create
        @user = User.new(user_params)

        if @user.save
            session[:userid] = @user.id
            redirect_to apikeys_path
        else
            render :action => "new"
        end
    end

    ## login stuff
    def login
        u = User.find_by_user_name(params[:user_name])
        if u && u.authenticate(params[:password])
            session[:user_id] = u.id
            redirect_to apikeys_path
        else
            flash[:notice] = "Failed!"
            redirect_to root_path
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to root_path, :notice => "logged out"
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :password, :password_confirmation)
    end
end
