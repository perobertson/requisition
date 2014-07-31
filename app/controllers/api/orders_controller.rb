class Api::OrdersController < Api::BaseApiController

  def create
    order = Order.new(permitted_params)

    if order.save
      flash[:success] = "Order placed"
      return render_nothing :no_content
    end

    render_nothing :unprocessable_entity
  end

  private

  def permitted_params
    params.require(:order).permit(:character_name, order_items_attributes: [:item_id, :quantity])
  end

end
