class ApikeysController < ApplicationController
    before_action :require_login

    def index
        if is_admin?
            @userApplikations = Applikation.all
        else
            @userApplikations = User.find(current_user.id).applikations
        end
    end

    def destroy
        @app = Applikation.find(params[:id])
        if @app.user_id == current_user.id || is_admin?
            @app.destroy
        end
        redirect_to apikeys_path
    end

    def new
        @app = Applikation.new
    end

    def create
        @app = Applikation.new(app_params)
        @app.user_id = current_user.id
        @app.appkey = SecureRandom.hex
        if @app.save
            redirect_to apikeys_path
        else
            render action: 'new'
        end
    end

    private
    def app_params
        params.require(:app).permit(:app_name)
    end
end
