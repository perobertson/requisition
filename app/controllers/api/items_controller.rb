class Api::ItemsController < Api::BaseApiController

  def index
    @items = Item.all
  end

  def create
    @item = Item.new permitted_create_params
    if @item.save
      flash[:success] = "Item created"
      return render status: :created
    end
    render status: :unprocessable_entity
  end

  def show
  end

  def update
    if @item.update permitted_update_params
      flash[:success] = "Item saved"
      return render_nothing :no_content
    end
    render_nothing :unprocessable_entity
  end

  private

  def set_resource
    @item = Item.find params[:id]
  end

  def permitted_create_params
    params.require(:item).permit(:type, :type_id, :name, :for_sale)
  end

  def permitted_update_params
    params.require(:item).permit(:for_sale)
  end

end
