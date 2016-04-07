class Api::V1::ApiBaseController < ApplicationController
    include Knock::Authenticable
    protect_from_forgery with: :null_session

    respond_to :json

    OFFSET = 0
    LIMIT = 15

    # retrives applicaktion key and checks if its valid
    def key_access
        appkey = Applikation.find_by(appkey: params[:appkey])
        unless appkey
          render json: { error: "invalid appkey"}, status: :unauthorized
        end
    end

    # 
    def offset_params
        @offset = params[:offset].to_i if params[:offset].present?
        @limit = params[:limit].to_i if params[:limit].present?

        @offset ||= OFFSET
        @limit  ||= LIMIT
    end
end
