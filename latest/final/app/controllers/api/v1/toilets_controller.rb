class Api::V1::ToiletsController < Api::V1::ApiBaseController
    skip_before_action :authenticate, only: [:index, :show]
    before_action :authenticate, only: [:create, :destroy, :update]
    before_action :offset_params, only: [:index]
    respond_to :json


    def index
        # checks if tag_id param is set
        if params[:tag_id].present?
            tag = Tag.find_by_id(params[:tag_id])
            toilet = tag.toilets unless tag.nil?
        # checks if address param is set
        elsif params[:address].present?
            location = Position.near(params[:address], 20)
            toilet = []
            location.each do |loc|
                toilet.push(Toilet.find_by_id(location.toilet_id))
            end
        # checks if creator_id param is set
        elsif params[:creator_id].present?
            creator = Creator.find_by_id(params[:creator_id])
            toilet = creator.toilets unless creator.nil?
        # checks if latitude and longitude param is set
        elsif params[:latitude] && params[:longitude]
            location = Position.near([params[:lat], params[:lon]], 50)
            toilet = []
            location.each do |loc|
                toilet.push(Toilet.find_by_id(location.toilet_id))
            end
        elsif params[:search]
          toilet = Toilet.where("name like ? OR description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
          #render json: {requested_events: @event}, status: :ok

        elsif params[:pos].present? # gets all toilets and joins toilet width positions if posible
            toilet = Toilet.all

            toilet = toilet.map { |t|
                jtoilet = Toilet.select("*").joins(:positions).find_by_id(t.id)

                if jtoilet.nil?
                    t
                else
                    t = jtoilet
                end
            }
        else
            # i none of the above params is set get all toilets
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

    # shows specifik toilet
    def show
        if params[:pos].present? # gets toilet and joins width positions if posible
            toilet = Toilet.select("*").joins(:positions).find_by_id(params[:id])

            if toilet.nil?
                toilet = Toilet.find_by_id(params[:id])
            else
                return respond_with :api, toilet
            end
        else
            toilet = Toilet.find_by_id(params[:id])
        end


        if toilet.nil?
            render json: { errors: "no toilet found! " }, status: :not_found
        else
            respond_with :api, toilet
        end
    end


    def create
        toilet = Toilet.new(toilet_params.except(:tags, :positions)) # creates new toilet width all parameters except tags, positions
        toilet.creator_id = current_user.id

        # checks if tags params excists
        if toilet_params[:tags].present?
            tag_params = toilet_params[:tags]

            tag_params.each do |tag|
                if Tag.find_by_name(tag['name']).present?
                    toilet.tags << Tag.find_by_name(tag['name']) # ads exsisting tag to toilet
                else
                    toilet.tags << Tag.create(tag) # creates new tag and ads it to toilet
                end
            end
        end

        if Toilet.find_by_name(toilet.name).present?
            render json: { errors: "toilet exsists! " }, status: :conflict
        elsif toilet.save

            # if save works check for position param
            if toilet_params[:positions].present?

                toilet_params[:positions].each do |pos|
                    if Position.find_by_address(pos['address']).present? # if position exsists throw error
                        render json: { errors: "position is used by a nother toilet! " }, status: :conflict
                    else
                        Position.create(address: pos['address'], toilet_id: toilet.id) # crates new position
                    end
                end
            end
            respond_with :api, toilet, status: :created
        else
            render json: { errors: toilet.errors.messages }, status: :bad_request
        end
    end

    # updates specifik toilet
    def update
        if toilet = Toilet.find_by_id(params[:id])

            # is positions param set
            if toilet_params[:positions].present?
                toilet_params[:positions].each do |pos|
                    Position.create(address: pos['address'], toilet_id: toilet.id) # crates new position
                end
            end

            # is tags param set
            if toilet_params[:tags].present?
                tag_params = toilet_params[:tags]
                toilet.tags = [] # emty tags
                tag_params.each do |tag|
                    if Tag.find_by_name(tag["name"]).present?
                        toilet.tags << Tag.find_by_name(tag["name"]) # ads exsisting tag to toilet
                    else
                        toilet.tags << Tag.create(tag) # creates new tag and ads it to toilet
                    end
                end
            end

            if toilet.update(toilet_params.except(:tags, :positions))
                toiletpos = toilet.positions.as_json(only: [:id, :address, :latitude, :longitude])
                respond_with :api, toilet do |format|
                    format.json { render json: { action: "update", toilet: {id: toilet.id, name: toilet.name, description: toilet.description, locations: toiletpos} }, status: :created }
                end
            else
                render json: { errors: toilet.errors.messages }, status: :bad_request
            end

        else
            render json: { errors: "toilet not found! " }, status: :not_found
        end
    end

    # removes specifik toilet
    def destroy
        if toilet = Toilet.find_by_id(params[:id])
            toilet.destroy
            render json: { action: "destroy", message: "toilet removed! ", status: :ok}
        else
            render json: { errors: "toilet not found! " }, status: :not_found
        end
    end

    private

    def toilet_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params.require(:toilet).permit(:name, :description, tags: [:name], positions: [:address])
    end

end
