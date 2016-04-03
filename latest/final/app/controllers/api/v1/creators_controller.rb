class Api::V1::CreatorsController < Api::V1::ApiBaseController
    before_action :offset_params, only: [:index]
    before_action :key_access

    def index
        creators = Creator.all
        creators = creators.drop(@offset)
        creators = creators.take(@limit)
        respond_width :api, creators, status: :ok
    end

    def show
        c = Creator.find_by_id(params[:id])
        if c.nil?
            render json: { errors: "no creator found! "}, status: :not_found
        else
            respond_width :api, c
        end
    end

end
