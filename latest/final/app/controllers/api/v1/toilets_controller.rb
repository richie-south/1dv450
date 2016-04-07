class Api::V1::ToiletsController < Api::V1::ApiBaseController
    skip_before_action :authenticate, only: [:index, :show]
    before_action :offset_params, only: [:index]
    respond_to :json

    def index
        if params[:tag_id].present?
            tag = Tag.find_by_id(params[:tag_id])
            toilet = tag.toilets unless tag.nil?
        elsif params[:creator_id].present?
            creator = Creator.find_by_id(params[:creator_id])
            toilet = creator.toilets unless creator.nil?
        elsif params[:address].present?
            location = Location.near(params[:address], 20)
            toilet = []
            location.each do |loc|
                toilet.push(Toilet.find_by_id(location.toilet_id))
            end
        elsif params[:latitude] && params[:longitude]
            location = Location.near([params[:lat], params[:lon]], 50)
            toilet = []
            location.each do |loc|
                toilet.push(Toilet.find_by_id(location.toilet_id))
            end
        else
            toilet = Toilet.all
        end

        if toilet.present?
            toilet = toilet.drop(@offset)
            toilet = toilet.take(@limit)

            respond_with :api, toilet, status: :ok
        else
            render json: { errors: "no toilet found! " }, status: :not_found
        end
    end

    def show
        toilet = Toilet.find_by_id(params[:id])
        if toilet.nil?
            render json: { errors: "no toilet found! " }, status: :not_found
        else
            respond_with :api, toilet
        end
    end


    def create
        toilet = Toilet.new(toilet_params.except(:tags, :positions))
        toilet.creator_id = current_user.id

        if toilet_params[:tags].present?
            tag_params = toilet_params[:tags]

            tag_params.each do |tag|
                if Tag.find_by_name(tag["name"]).present?
                    toilet.tags << Tag.find_by_name(tag["name"])
                else
                    toilet.tags << Tag.create(tag)
                end
            end
        end

        if Toilet.find_by_name(toilet.name).present?
            render json: { errors: "toilet exsists! " }, status: :conflict
        elsif toilet.save

            if toilet_params[:positions].present?
                toilet_params[:positions].each do |pos|
                    l = Position.find_by_address(pos["address"])
                    Position.create(address: pos["address"], toilet_id: toilet.id)
            end
        end
            respond_with :api, toilet, status: :created
        else
            render json: { errors: toilet.errors.messages }, status: :bad_request
        end

    end


    def update
    end


    def destroy
    end

    private

    def toilet_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params.require(:toilet).permit(:name, :description, tags: [:name], positions: [:address])
    end

end
