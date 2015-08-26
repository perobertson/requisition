class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    return user_not_authorized unless current_user.can_view_category?

    @categories = Category.not_deleted.order :name
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    return user_not_authorized unless current_user.can_view_category?
  end

  # GET /categories/new
  def new
    return user_not_authorized unless current_user.can_add_category?

    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    return user_not_authorized unless current_user.can_change_category?
  end

  # POST /categories
  # POST /categories.json
  def create
    return user_not_authorized unless current_user.can_add_category?

    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    return user_not_authorized unless current_user.can_change_category?

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    return user_not_authorized unless current_user.can_change_category?

    @category.deleted_at = Time.current
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name)
  end
end
