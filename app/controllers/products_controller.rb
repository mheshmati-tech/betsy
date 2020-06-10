class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
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
    if @product.save
      flash[:success] = "#{@product.name} successfully added!"
      redirect_to products_path
      # TODO - we want to redirect to users products
      return
    else
      flash.now[:error] = "Unable to add #{@product.name}"
      render :new
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
    # TODO - we want to redirect to users products
    return
    else
      flash.now[:error] = "Unable to edit #{@product.name}"
      render :edit
      return
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = "#{@product.name} successfully deleted"
      redirect_to root_path
      # TODO - what happens to a products associated data? 
    end
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_path #TODO - what is the best thing to do when prodcut is not found
      return
    end
  end

  def product_params
    return params.require(:product).permit(:name, :price, :description, :photo_url, :stock)
    #TODO - category - add to params
  end
end
