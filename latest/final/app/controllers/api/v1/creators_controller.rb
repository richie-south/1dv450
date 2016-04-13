class Api::V1::CreatorsController < Api::V1::ApiBaseController
    before_action :offset_params, only: [:index]
    before_action :key_access

    # shows all creators
    def index
        creators = Creator.all
        creators = creators.drop(@offset)
        creators = creators.take(@limit)
        respond_width :api, creators, status: :ok
    end

    # shows specifik creator
    def show
        creator = Creator.find_by_id(params[:id])
        if c.nil?
            render json: { errors: "no creator found! "}, status: :not_found
        else
            respond_width :api, creator
        end
    end

    def creator_by_name
        respond_with :api, Creator.find_by_name(params[:name])
    end

end
