module Api
  class OrdersController < Api::BaseApiController
    def index
      @orders = policy_scope Order.all
    end

    def create
      @resource = current_user.orders.new permitted_params
      authorize @resource
      if @resource.save
        return render :show, status: :created
      end

      render status: :unprocessable_entity
    end

    def show
    end

  private

    def set_resource
      @resource = Order.find params[:id]
      authorize @resource
    end

    def permitted_params
      params.require(:order).permit(order_items_attributes: [:item_id, :quantity])
    end
  end
end
