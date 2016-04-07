class Api::V1::TagsController <  Api::V1::ApiBaseController
    before_action :offset_params, only: [:index]
    before_action :key_access
    before_action :authenticate, only: [:create, :destroy, :update]

    # gets all tags or gets all tags for specifik toilet
    def index
        if params[:toilet_id].present?
            to = Toilet.find_by_id(params[:toilet_id])
            tags = to.tags unless to.nil?
        else
            tags = Tag.all # gets all tags if no toilet_id is set
        end

        if tags.present?
            tags = tags.drop(@offset)
            tags = tags.take(@limit)

            respond_with :api, tags, status: :ok
        else
            render json: { errors: "no tags found! " }, status: :not_found
        end
    end

    # shows specifik tag
    def show
        t = Tag.find_by_id(params[:id])
        if t.nil?
          render json: { errors: "no tag found! " }, status: :not_found
        else
          respond_with :api, t
        end
    end

    # creates a tag and chesk if it alrady exists
    def create
        t = Tag.new(tag_params)
        if Tag.where(name: t.name).present? # cheks if it exists
            render json: { errors: "tag already exsists" }, status: :conflict
        else
            if t.save
                respond_with :api, t, status: :created
            else
                render json: { errors: "tag already exsists" }, status: :conflict
            end
        end
    end

    # update specifik tag
    def update
        if t = Tag.find_by_id(params[:id])

            if Tag.find_by_name(tag_params['name']).present? # checks if tag name alredy exsists
                render json: { errors: "tag already exsists" }, status: :conflict
            else
                if t.update(tag_params)
                    tjson = t.as_json(only: [:id, :name])
                    respond_with :api, t do |format|
                        format.json { render json: { action: "update", tag: tjson }, status: :created }
                    end
                else
                    render json: { errors: t.errors.messages }, status: :bad_request
                end
            end
        else
            render json: { errors: "no tag found! " }, status: :not_found
        end
    end

    # removes specifik tag
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
