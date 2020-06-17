class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy, :change_product_status]

  def index
    @products = Product.where(product_status: "active")
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(
      product_params
    )
    if !@logged_user
      flash[:error] = "You must be logged in to create a new product."
      redirect_to root_path
      return
    end
    @product.user_id = @logged_user.id
    if @product.save
      flash[:success] = "#{@product.name} successfully added!"
      redirect_to products_path
      return
    else
      flash.now[:error] = "Unable to add #{@product.name}. Errors: #{@product.errors.messages}"
      render :new, status: :bad_request
      return
    end
  end

  def edit
  end

  def update
    if @product.update(
      product_params
    )
      flash[:success] = "#{@product.name} successfully edited"
      redirect_to products_path
      return
    else
      flash.now[:error] = "Unable to edit #{@product.name}. Errors: #{@product.errors.messages}"
      render :edit
      return
    end
  end


  #TODO: do we even need this?
  def destroy
    if @product.destroy
      flash[:success] = "#{@product.name} successfully deleted"
      redirect_to root_path
      # TODO - what happens to a products associated data?
    end
  end

  def change_product_status
    if @product.product_status == "active"
      @product.product_status = "inactive"
    elsif @product.product_status == "inactive"
      @product.product_status = "active"
    end
    @product.save
    redirect_to myaccount_path
    return
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_path 
      return
    end
  end


  def product_params
    return params.require(:product).permit(:name, :price, :description, :photo_url, :stock, :user_id, :product_status, category_ids: [])
  end
end
