module Api
  class ItemsController < Api::BaseApiController
    def index
      @items = policy_scope Item.all
    end

    def create
      @resource = Item.new permitted_create_params
      authorize @resource
      if @resource.save
        return render :show, status: :created
      end
      render status: :unprocessable_entity
    end

    def show
    end

    def update
      if @resource.update permitted_update_params
        return render_nothing :no_content
      end
      render_nothing :unprocessable_entity
    end

  private

    def set_resource
      @resource = Item.find params[:id]
      authorize @resource
    end

    def permitted_create_params
      params.require(:item).permit(:category_id, :type_id, :name, :for_sale, :rendered)
    end

    def permitted_update_params
      params.require(:item).permit(:category_id, :for_sale, :rendered)
    end
  end
end
