module Api
  class OrdersController < Api::BaseApiController
    def index
      @orders = policy_scope Order.all
    end

    def create
      unless current_user.can_place_order?
        flash[:danger] = 'You are not allowed to place orders'
        return render_nothing :unauthorized
      end

      @order = current_user.orders.new permitted_params
      authorize @order
      if @order.save
        flash[:success] = 'Order placed'
        return render :show, status: :created
      end

      render status: :unprocessable_entity
    end

    def show
    end

  private

    def set_resource
      @order = Order.find params[:id]
      authorize @order
    end

    def permitted_params
      params.require(:order).permit(order_items_attributes: [:item_id, :quantity])
    end
  end
end
