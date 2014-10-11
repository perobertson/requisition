class Api::ItemsController < Api::BaseApiController

  def update
    item = Item.find params[:id]
    if item.update permitted_params
      flash[:success] = "Item saved"
      return render_nothing :no_content
    end
    render_nothing :unprocessable_entity
  end

  private

  def permitted_params
    params.require(:item).permit(:for_sale)
  end

end
