class Api::V1::PositionsController < Api::V1::ApiBaseController
    before_action :offset_params, only: [:index]
    before_action :key_access
    before_action :authenticate, only: [:create, :destroy, :update]

    def index
        if params[:toilet_id].present?
            to = Toilet.find_by_id(params[:toilet_id])
            po = to.positions unless to.nil?
        else
            po = Position.all
        end

        if po.present?
            po = po.drop(@offset)
            po = po.take(@limit)

            respond_with :api, po, status: :ok
        else
            render json: { errors: "no positions found! " }, status: :not_found
        end
    end

    def show
        po = Position.find_by_id(params[:id])
        if po.nil?
            render json: { errors: "no position found! "}, status: :not_found
        else
            respond_width :api, po
        end
    end

    def create
        po = Position.new(pos_params)
        if Position.where(address: po.address).present?
            render json: { errors: "position already exsists" }, status: :conflict
        else
            if po.save
                respond_with :api, po, status: :created
            else
                render json: { errors: po.errors.messages }, status: :bad_request
            end
        end
    end

    def update
        if pos = Position.find_by_id(params[:id])

            if pos.update(pos_params)
                posjson = pos.as_json(only: [:id, :address, :latitude, :longitude])

                respond_with :api, pos do |format|
                    format.json { render json: { action: "update", cordinates: posjson }, status: :accepted }
                end
            else
                render json: { errors: pos.errors.messages }, status: :bad_request
            end
        else
            render json: { errors: "no position found! " }, status: :not_found
        end
    end

    def destroy
        if po = Position.find_by_id(params[:id])
            po.destroy
            render json: { action: "destroy", message: "position removed! ", status: :ok}
        else
            render json: { errors: "no position found! " }, status: :not_found
        end
    end

    private

    def pos_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params.require(:position).permit(:address, :toilet_id)
    end


end
