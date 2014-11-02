class Api::OrdersController < Api::BaseApiController

  def create
    if !current_user.can_place_order?
      flash[:danger] = "You are not allowed to place orders"
      return render_nothing :unauthorized
    end

    @order = Order.new(permitted_params)
    if @order.save
      flash[:success] = "Order placed"
      return render status: :created
    end

    render status: :unprocessable_entity
  end

  private

  def permitted_params
    params.require(:order).permit(:character_name, order_items_attributes: [:item_id, :quantity])
  end

end
