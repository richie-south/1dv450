class ApplikationsController < ApplicationController

    def index
        @app = Applikation.all
    end

    def new
        @app = Applikation.new
    end

    def create
        @app = Applikation.new(app_params)
        @app.appkey = SecureRandom.hex
        if @app.save
            redirect_to applikations_path
        else
            render :action => "new"
        end
    end

    private

    def app_params
        params.require(:app).permit(:app_name)
    end
end
