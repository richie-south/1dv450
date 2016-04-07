class Api::V1::TagsController <  Api::V1::ApiBaseController
    before_action :offset_params, only: [:index]
    before_action :key_access
    before_action :authenticate, only: [:create, :destroy, :update]

    def index
        tag = Tag.all
        tag = tag.drop(@offset)
        tag = tag.take(@limit)
        respond_with :api, tag, status: :ok
    end

    def show
        t = Tag.find_by_id(params[:id])
        if t.nil?
          render json: { errors: "no tag found! " }, status: :not_found
        else
          respond_with :api, t
        end
    end

    def create
        t = Tag.new(tag_params)
        if Tag.find_by_name(t.name).nil?
            if t.save
                respond_with :api, t, status: :created
            else
                render json: { errors: t.errors.messages }, status: :bad_request
            end
        else
            render json: { errors: "tag already exsists" }, status: :conflict
        end
    end

    def update
        if t = Tag.find_by_id(params[:id])

            if t.update(tag_params)
                tjson = t.as_json(only: [:id, :name])

                respond_with :api, t do |format|
                    format.json { render json: { action: "update", tag: tjson }, status: :created }
                end
            else
                render json: { errors: t.errors.messages }, status: :bad_request
            end
        else
            render json: { errors: "no tag found! " }, status: :not_found
        end
    end

    def destroy
        if t = Tag.find_by_id(params[:id])
            t.destroy
            render json: { action: "destroy", message: "tag removed.", status: :ok}
        else
            render json: { errors: "no tag found! " }, status: :not_found
        end
    end

    private

    def tag_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params.require(:tag).permit(:name)
    end

end
