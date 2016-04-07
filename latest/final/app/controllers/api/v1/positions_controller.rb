class Api::V1::PositionsController < Api::V1::ApiBaseController
    before_action :offset_params, only: [:index]
    before_action :key_access
    before_action :authenticate, only: [:create, :destroy, :update]

    # shows all positions, shows all positions on toilet
    def index
        if params[:toilet_id].present?
            to = Toilet.find_by_id(params[:toilet_id])
            position = to.positions unless to.nil?
        else
            position = Position.all # gets all positions if no toilet_id is set
        end

        if position.present?
            position = position.drop(@offset)
            position = position.take(@limit)

            respond_with :api, position, status: :ok
        else
            render json: { errors: "no positions found! " }, status: :not_found
        end
    end

    # shows specifik position
    def show
        position = Position.find_by_id(params[:id])
        if position.nil?
            render json: { errors: "no position found! "}, status: :not_found
        else
            respond_width :api, position
        end
    end

    # creates new position if it dont already exists
    def create
        position = Position.new(pos_params)
        if Position.where(address: position.address).present?
            render json: { errors: "position already exsists" }, status: :conflict
        else
            if position.save
                respond_with :api, position, status: :created
            else
                render json: { errors: position.errors.messages }, status: :bad_request
            end
        end
    end

    # updates position
    def update
        if pos = Position.find_by_id(params[:id])
            if Position.find_by_address(pos_params['address']).present? # checks if position address alredy exsists
                render json: { errors: "position already exsists" }, status: :conflict
            else
                if pos.update(pos_params)
                    posjson = pos.as_json(only: [:id, :address, :latitude, :longitude])

                    respond_with :api, pos do |format|
                        format.json { render json: { action: "update", cordinates: posjson }, status: :accepted }
                    end
                else
                    render json: { errors: pos.errors.messages }, status: :bad_request
                end
            end
        else
            render json: { errors: "no position found! " }, status: :not_found
        end
    end

    # destorys specifik position
    def destroy
        if po = Position.find_by_id(params[:id])
            po.destroy
            render json: { action: "destroy", message: "position removed! ", status: :ok}
        else
            render json: { errors: "no position found! " }, status: :not_found
        end
    end

    private

    # gets specifik params
    def pos_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params.require(:position).permit(:address, :toilet_id)
    end


end
