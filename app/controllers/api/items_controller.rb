module Api
  class ItemsController < Api::BaseApiController
    def index
      @items = policy_scope Item.all
    end

    def create
      @item = Item.new permitted_create_params
      authorize @item
      if @item.save
        return render :show, status: :created
      end
      render status: :unprocessable_entity
    end

    def show
    end

    def update
      if @item.update permitted_update_params
        return render_nothing :no_content
      end
      render_nothing :unprocessable_entity
    end

  private

    def set_resource
      @item = Item.find params[:id]
      authorize @item
    end

    def permitted_create_params
      params.require(:item).permit(:category_id, :type_id, :name, :for_sale, :rendered)
    end

    def permitted_update_params
      params.require(:item).permit(:category_id, :for_sale, :rendered)
    end
  end
end
